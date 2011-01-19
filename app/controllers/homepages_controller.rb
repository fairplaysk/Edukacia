class HomepagesController < ApplicationController
  def home
    @categories = Category.limit(7)
  end
  
end
