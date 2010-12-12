class QuizzesController < ApplicationController
  # GET /quizzes
  # GET /quizzes.xml
  def index
    @quizzes = Quiz.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.xml
  def new
    @quiz = Quiz.new(session[:quiz])
    if session[:quiz]
      session[:quiz][:placement_comments_attributes].each { |key,value| @quiz.placement_comments.build if value[:content].empty? }
      if session[:add_placement_comment] && @quiz.placement_comments.length < 6
        @quiz.placement_comments.build
        session[:add_placement_comment] = nil
      elsif session[:remove_placement_comment]
        @quiz.placement_comments.pop
        session[:remove_placement_comment] = nil
      end
    else
      4.times { @quiz.placement_comments.build } 
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    if session[:quiz] && session[:quiz][:id] == params[:id]
      @quiz.placement_comments = []
      session[:quiz][:placement_comments_attributes].each { |key, value| @quiz.placement_comments.build(:content => value[:content]) } if session[:quiz][:placement_comments_attributes]
      if session[:add_placement_comment] && @quiz.placement_comments.length < 6
        @quiz.placement_comments.build
        session[:add_placement_comment] = nil
      elsif session[:remove_placement_comment]
        @quiz.placement_comments.pop
        session[:remove_placement_comment] = nil
      end
    end
  end

  # POST /quizzes
  # POST /quizzes.xml
  def create
    @quiz = Quiz.new(params[:quiz])
    if params[:add_placement_comment] || params[:remove_placement_comment]
      session[:quiz] = params[:quiz]
      session[:remove_placement_comment] = 1 if params[:remove_placement_comment]
      session[:add_placement_comment] = 1 if params[:add_placement_comment]
      redirect_to :action => 'new'
    else
      session[:quiz] = nil
      respond_to do |format|
        if @quiz.save
          format.html { redirect_to(@quiz, :notice => 'Quiz was successfully created.') }
          format.xml  { render :xml => @quiz, :status => :created, :location => @quiz }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.xml
  def update
    @quiz = Quiz.find(params[:id])
    if params[:add_placement_comment] || params[:remove_placement_comment]
      session[:quiz] = params[:quiz]
      session[:quiz][:id] = params[:id]
      session[:remove_placement_comment] = 1 if params[:remove_placement_comment]
      session[:add_placement_comment] = 1 if params[:add_placement_comment]
      redirect_to :action => 'edit'
    else
      session[:quiz] = nil
      respond_to do |format|
        if @quiz.update_attributes(params[:quiz])
          format.html { redirect_to(@quiz, :notice => 'Quiz was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.xml
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
end
