class ApplicationController < ActionController::Base
  layout 'frontend'
  
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :prepare_for_mobile
  
  private
  def set_locale
    session[:locale] = :sk if session[:locale].blank?
    I18n.locale = session[:locale].to_sym 
  end
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
