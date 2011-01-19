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
  end
  
  def create
    submission = Submission.new(:quiz_id => params[:quiz_id])
    submission.session_id = session[:session_id]
    params[:submission][:questions_attributes].each do |question_id, answer|
      submission.answers << Answer.find(answer[:answer_ids])
    end
    submission.save
    redirect_to submission
  end
  
  def show
    @submission = Submission.find(params[:id])
  end
end
