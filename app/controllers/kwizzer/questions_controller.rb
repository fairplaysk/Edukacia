module Kwizzer
  class QuestionsController < ApplicationController
    # GET /questions
    # GET /questions.xml
    def index
      @quiz = Quiz.find(params[:quiz_id])
      @quiz.questions.build if @quiz.questions.empty?
      @quiz.questions.each do |q| 
        4.times { q.answers.build  } if q.answers.empty?
      end

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @questions }
      end
    end

    # GET /questions/1
    # GET /questions/1.xml
    def show
      @question = Question.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @question }
      end
    end

    # GET /questions/new
    # GET /questions/new.xml
    def new
      @question = Question.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @question }
      end
    end

    # GET /questions/1/edit
    def edit
      @question = Question.find(params[:id])
    end

    # POST /questions
    # POST /questions.xml
    def create
      @question = Question.new(params[:question])

      respond_to do |format|
        if @question.save
          format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
          format.xml  { render :xml => @question, :status => :created, :location => @question }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /questions/1
    # PUT /questions/1.xml
    def update
      @question = Question.find(params[:id])

      respond_to do |format|
        if @question.update_attributes(params[:question])
          format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /questions/1
    # DELETE /questions/1.xml
    def destroy
      @question = Question.find(params[:id])
      @question.destroy

      respond_to do |format|
        format.html { redirect_to(questions_url) }
        format.xml  { head :ok }
      end
    end
  
    def save_all
      @quiz = Quiz.find(params[:quiz_id])
      
      respond_to do |format|
        if @quiz.update_attributes(params[:quiz])
          format.html { redirect_to(kwizzer_quiz_path(@quiz), :notice => 'Successfully updated questions for this quiz.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "index" }
          format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end