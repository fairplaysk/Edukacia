class ApplicationController < ActionController::Base
  layout 'frontend'
  
  protect_from_forgery
  
  before_filter :set_locale
  
  private
  def set_locale
    I18n.locale = session[:locale].to_sym unless session[:locale].blank?
  end
end
