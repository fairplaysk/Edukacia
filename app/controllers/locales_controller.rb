class LocalesController < ApplicationController
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    redirect_to root_path
  end
end
