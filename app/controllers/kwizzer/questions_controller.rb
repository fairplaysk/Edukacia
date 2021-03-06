module Kwizzer
  class QuestionsController < ApplicationController
    
    def index
      @quiz = Quiz.find(params[:quiz_id])
      @quiz.questions.build if @quiz.questions.empty?
      @quiz.questions.each do |q| 
        4.times { q.answers.build  } if q.answers.empty?
      end
    end
  
    def save_all
      @quiz = Quiz.find(params[:quiz_id])
      schuffle_answer_values
      @quiz.update_attributes(params[:quiz])
      if params[:add_answer]
        index = Regexp.new(/#(\d+)$/).match(params[:add_answer])[1].to_i
        @quiz.questions[index-1].answers.build
        render 'index' and return
      elsif params[:remove_answer]
        index = Regexp.new(/#(\d+)$/).match(params[:remove_answer])[1].to_i
        @quiz.questions[index-1].answers.delete(@quiz.questions[index-1].answers.last)
        render 'index' and return
      elsif params[:add_question]
        @quiz.questions.create
        render 'index' and return
      elsif params[:remove_question]
        @quiz.questions.delete(@quiz.questions.last)
        render 'index' and return
      end
      
      if @quiz.save
        redirect_to(kwizzer_quiz_path(@quiz), :notice => 'Successfully updated questions for this quiz.')
      else
        render 'index'
      end
    end
    
    private
    def schuffle_answer_values
      params[:quiz][:questions_attributes].each do |key, value|
        correct_value = value[:answers_attributes].delete(:is_correct) if value[:answers_attributes]
        value[:answers_attributes][correct_value][:is_correct] = "1" if correct_value
        funny_value = value[:answers_attributes].delete(:is_funny) if value[:answers_attributes]
        value[:answers_attributes][funny_value][:is_funny] = "1" if funny_value
      end
    end
    
  end
end