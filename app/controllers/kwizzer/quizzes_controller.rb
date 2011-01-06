module Kwizzer
  class QuizzesController < ApplicationController
    before_filter :add_remove_placement_comments, :only => [:create, :update]
    
    def index
      @quizzes = Quiz.all
    end

    def show
      @quiz = Quiz.find(params[:id])
    end

    def new
      @quiz = Quiz.new(session[:quiz])
      4.times { @quiz.placement_comments.build }
    end

    def edit
      @quiz = Quiz.find(params[:id])
    end

    def create
      if @quiz.save
        redirect_to(kwizzer_quiz_questions_path(@quiz), :notice => 'Successfully saved quiz. Please fill out questions for the quiz next.')
      else
        render 'new'
      end
    end

    def update
      if @quiz.update_attributes(params[:quiz])
        redirect_to(kwizzer_quiz_questions_path(@quiz), :notice => 'Successfully saved quiz. Please fill out questions for the quiz next.')
      else
        render :action => "edit"
      end
    end

    def destroy
      @quiz = Quiz.find(params[:id])
      @quiz.destroy
      redirect_to(kwizzer_quizzes_url)
    end
    
    private
    def add_remove_placement_comments
      @quiz = params[:id] ? Quiz.find(params[:id]) : Quiz.new(params[:quiz])
      if params[:add_placement_comment] || params[:remove_placement_comment]
        @quiz.placement_comments.build if @quiz.placement_comments.length < 6 && params[:add_placement_comment]
        @quiz.placement_comments.pop if @quiz.placement_comments.length > 3 if params[:remove_placement_comment]
        params[:id] ? render('edit') : render('new')
      end
    end
  end
end