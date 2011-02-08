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
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions_for_page(params[:page].to_i)
    @last_page = @quiz.questions_per_page*params[:page].to_i >= @quiz.questions.length
  end
  
  def create
    if params[:questions]
      submission = Submission.find_or_initialize_by_session_id_and_quiz_id(session[:session_id], params[:quiz_id])
      submission = Submission.new(:session_id => session[:session_id], :quiz_id => params[:quiz_id], :is_repeated => true) if params[:page] == '1' && !submission.new_record?
      params[:questions].each do |question_id, answer|
        submission.answers << Answer.find(answer[:answer_ids])
      end
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
  end
end
