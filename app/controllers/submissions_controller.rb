class SubmissionsController < ApplicationController
  def index
    if mobile_device?
      @category = Category.find(params[:category_id])
    else
      @categories = Category.includes(:quizzes => :submissions)
      @session_id = session[:session_id]
    end
  end
  
  def new
    if params[:quiz_id] == 'random'
      @quiz = Quiz.create(:is_generated => true, :questions_per_page => 1, :name => 'Random quiz', :categories => [Category.find_or_create_by_name_and_short_name('Random', 'Random')])
      @quiz.questions.push_with_attributes(Question.where(:random_enabled => true).order('rand()').limit(4), :is_generated => true)
      @quiz.save
    else
      @quiz = Quiz.find(params[:quiz_id])
    end
    @questions = @quiz.questions_for_page(params[:page].to_i)
    @last_page = @quiz.questions_per_page*params[:page].to_i >= @quiz.questions.length
  end
  
  def create
    if params[:questions] || params[:commit] == I18n.translate('submissions.new.skip')
      submission = Submission.find_or_initialize_by_session_id_and_quiz_id(session[:session_id], params[:quiz_id])
      submission = Submission.new(:session_id => session[:session_id], :quiz_id => params[:quiz_id], :is_repeated => true) if params[:page] == '1' && !submission.new_record?
      
      params[:questions].each do |question_id, answer|
        submission.answers << Answer.find(answer[:answer_ids])
      end unless params[:commit] == I18n.translate('submissions.new.skip')
      
      submission.save
      if submission.quiz.questions_per_page*params[:page].to_i >= submission.quiz.questions.length
        redirect_to submission
      else
        redirect_to new_submission_path(:quiz_id => params[:quiz_id], :page => params[:page].to_i+1)
      end
    else
      redirect_to new_submission_path(:quiz_id => params[:quiz_id], :page => params[:page]), :notice => 'Please select an answer.'
    end
  end
  
  def show
    @submission = Submission.find(params[:id])
    
    @correct_answers_percentage = (@submission.correct_answers_count.to_f*100) / @submission.quiz.questions.count.to_f if @submission.quiz.questions.count != 0
    @average_submission_percentate = quiz_submission_percentage(@submission.quiz)
    
    @easiest_quiz, @hardest_quiz = @submission.quiz, @submission.quiz
    
    Quiz.all.each do |quiz|
      @easiest_quiz = quiz if quiz_submission_percentage(quiz) < quiz_submission_percentage(@easiest_quiz)
      @hardest_quiz = quiz if quiz_submission_percentage(quiz) > quiz_submission_percentage(@hardest_quiz)
    end
    
    if @correct_answers_percentage
      if @correct_answers_percentage == 100
        @placement_comment = @submission.quiz.placement_comments.last
      elsif @submission.quiz.placement_comments.count > 0
        @placement_comment = @submission.quiz.placement_comments[@correct_answers_percentage / (100/@submission.quiz.placement_comments.count)]
      end
    end
  end
  
  private
  def quiz_submission_percentage(quiz)
    quiz.first_submissions.inject(0.0) do |sum, submission|
      sum + (submission.correct_answers_count.to_f*100) / submission.quiz.questions.count.to_f if submission.quiz.questions.count != 0
    end / quiz.first_submissions.count
  end
end
