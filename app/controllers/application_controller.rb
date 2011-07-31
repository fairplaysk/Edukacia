class ApplicationController < ActionController::Base
  layout 'frontend'
  
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :prepare_for_mobile
  before_filter :load_header_and_footer_text
  
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
  
  def load_header_and_footer_text
    @header_text =  Label.find_by_identifier_and_language('header', session[:locale].to_s).try(:content)
    @footer_text = Label.find_by_identifier_and_language('footer', session[:locale].to_s).try(:content)
    @meta_text = Label.find_by_identifier_and_language('meta', session[:locale].to_s).try(:content)
  end
end
