require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    before_filter :super_user!
    
    private
    def super_user!
      unless current_user && current_user.super?
        flash[:error] = "This section requires admin priviledges!"
        redirect_to root_path
      end
    end
  end
end