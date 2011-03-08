class HomepagesController < ApplicationController
  def home
    @categories = Category.order_by_popularity.limit(7).all
    @categories = Category.limit(7) unless @categories.present?
  end
  
end
