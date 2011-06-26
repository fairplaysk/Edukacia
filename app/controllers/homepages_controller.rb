class HomepagesController < ApplicationController
  respond_to :html, :json
  
  def home
    @categories = Category.order_by_popularity.limit(7).all
    @categories = Category.where('name != ?', 'Random').limit(7) if @categories.empty?
    respond_with @categories
  end
  
  def contact
    @contact = Label.find_by_identifier_and_language('contact', session[:locale].to_s)
    respond_with @contact
  end
  
  def about
    @about = Label.find_by_identifier_and_language('about', session[:locale].to_s)
    respond_with @about
  end
  
  def statistics
    if params[:which] == 'submission_history'
      json_object = Choise.submission_history_statistics
    elsif params[:which] == 'chart_correct_incorrect'
      json_object = Choise.chart_correct_incorrect
    elsif params[:which] == 'chart_hardest'
      json_object = Choise.chart_hardest
    elsif params[:which] == 'chart_easiest'
      json_object = Choise.chart_easiest
    elsif params[:which] == 'most_popular_quiz'
      json_object = Choise.most_popular_quiz
    end
    respond_to do |format|
      format.html
      format.json {render :json => json_object.to_json}
    end
  end
end
