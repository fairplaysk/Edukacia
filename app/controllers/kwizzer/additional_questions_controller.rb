module Kwizzer
  class AdditionalQuestionsController < ::ApplicationController
    def index
      @quiz = Quiz.find(params[:quiz_id])
      @quiz.additional_questions.build if @quiz.additional_questions.empty?
    end
    
    def save_all
      @quiz = Quiz.find(params[:quiz_id])
      
      if @quiz.update_attributes(params[:quiz])
        redirect_to(kwizzer_quizzes_path, :notice => 'Additional user questions successfully updated.')
      else
        render :action => "index"
      end
    end
  end
end