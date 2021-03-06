class SubmissionsController < ApplicationController
  def index
    if mobile_device?
      @category = Category.find(params[:category_id])
    else
      @categories = Category.includes(:quizzes => :submissions)
      @session_id = get_submission_token
    end
  end
  
  def new
    # FIXME: refactor
    if params[:quiz_id] == 'random' || params[:quiz_id] == 'random_hard' || params[:quiz_id] == 'random_easy'
      @quiz = Quiz.create(:is_generated => true, :questions_per_page => 1, :name => 'Random quiz', :categories => [Category.find_or_create_by_name_and_short_name('Random', 'Random')])
      questions = Question.where(:random_enabled => true).order('rand()').limit(5) if params[:quiz_id] == 'random'
      questions = Question.where(:random_enabled => true).order('average_percentage asc').limit(10) if params[:quiz_id] == 'random_hard'
      questions = Question.where(:random_enabled => true).order('average_percentage desc').limit(10) if params[:quiz_id] == 'random_easy'
      @quiz.questions.push_with_attributes(questions, :is_generated => true)
      @quiz.save
    else
      @quiz = Quiz.find(params[:quiz_id])
    end
    @questions = @quiz.questions_for_page(params[:page].to_i)
    @last_page = @quiz.questions_per_page*params[:page].to_i >= @quiz.questions.length
  end
  
  def create
    # FIXME: refactor
    if params[:questions] || params[:commit] == I18n.translate('submissions.new.skip')
      submission = Submission.find_or_initialize_by_session_id_and_quiz_id(get_submission_token, params[:quiz_id])
      submission = Submission.new(:session_id => get_submission_token, :quiz_id => params[:quiz_id], :is_repeated => true) if params[:page] == '1' && !submission.new_record?
      
      params[:questions].each do |question_id, answer|
        submission.answers << Answer.find(answer[:answer_ids])
      end unless params[:commit] == I18n.translate('submissions.new.skip')
      
      submission.user = current_user unless submission.user.present?
      
      submission.save
      if submission.quiz.questions_per_page*params[:page].to_i >= submission.quiz.questions.length
        redirect_to submission
      else
        redirect_to new_submission_path(:quiz_id => params[:quiz_id], :page => params[:page].to_i+1)
      end
    else
      redirect_to new_submission_path(:quiz_id => params[:quiz_id], :page => params[:page]), :alert => I18n.translate('submissions.new.answer_required')
    end
  end
  
  def show
    # FIXME: refactor
    @submission = Submission.find(params[:id])
    
    @quiz_submission_rating = @submission.quiz.submissions.where('(submissions.session_id = ? OR submissions.user_id = ?) AND submissions.rating IS NOT NULL', get_submission_token, current_user).first.try(:rating) if @can_rate = can_rate(@submission)
    @rating_count = @submission.quiz.submissions.where('submissions.rating IS NOT NULL').count
    @average_rating = @submission.quiz.submissions.where('submissions.rating IS NOT NULL').average(:rating)
    
    @correct_answers_percentage = (@submission.correct_answers_count.to_f*100) / @submission.quiz.questions.count.to_f if @submission.quiz.questions.count != 0

    @average_submission_percentate = @submission.quiz.quiz_submission_percentage
    @submission.quiz.update_attribute(:average_percentage, @average_submission_percentate)
    
    @easiest_quiz = Quiz.where(:is_generated => false).order(:average_percentage).last || Quiz.first
    @hardest_quiz = Quiz.where(:is_generated => false).order(:average_percentage).first || Quiz.last
    
    if @correct_answers_percentage
      if @correct_answers_percentage == 100
        @placement_comment = @submission.quiz.placement_comments.last
      elsif @submission.quiz.placement_comments.count > 0
        @placement_comment = @submission.quiz.placement_comments[@correct_answers_percentage / (100/@submission.quiz.placement_comments.count)]
      end
    end
  end
  
  def rate
    # FIXME: refactor
    @submission = Submission.find(params[:id])
    unless @submission.quiz.is_generated?
      @quiz_submission_rating = @submission.quiz.submissions.where('(submissions.session_id = ? OR submissions.user_id = ?) AND submissions.rating IS NOT NULL', get_submission_token, current_user).first
      if @quiz_submission_rating.try(:present?)
        @quiz_submission_rating.update_attribute(:rating, params[:rating])
        @can_rate = true
      elsif @can_rate = can_rate(@submission)
        @submission.update_attribute(:rating, params[:rating])
      end
      @quiz_submission_rating = params[:rating].to_i
      @average_rating = @submission.quiz.submissions.where('submissions.rating IS NOT NULL').average(:rating)
      @rating_count = @submission.quiz.submissions.where('submissions.rating IS NOT NULL').count
    end
    if mobile_device?
      redirect_to @submission
    else
      render :partial => 'rating', :layout => false
    end
  end
  
  private
  def can_rate(submission)
    (current_user && submission.user == current_user) || submission.session_id == get_submission_token
  end
  def get_submission_token
    cookies.permanent[:submission_token] = cookies[:submission_token].present? ? cookies[:submission_token] : Submission.generate_token
  end
end
