class HomepagesController < ApplicationController
  respond_to :html
  
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
end
