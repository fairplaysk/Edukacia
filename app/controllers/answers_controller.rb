class AnswersController < ApplicationController
  def index
    @quizzes = Quiz.all
  end
  
  def new
  end
end
