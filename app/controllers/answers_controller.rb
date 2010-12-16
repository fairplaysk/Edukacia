class AnswersController < ApplicationController
  def index
    @quizzes = Quiz.all
  end
end
