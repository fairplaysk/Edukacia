class HomepagesController < ApplicationController
  def home
    @categories = Category.order_by_popularity.limit(7).all
    @categories = Category.where('name != ?', 'Random').limit(7) if @categories.empty?
  end
  
end
