class LocalesController < ApplicationController
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    redirect_to :back
  end
end
