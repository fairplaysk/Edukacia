module Kwizzer
  class ApplicationController < ::ApplicationController
    layout 'backend'
    
    before_filter :authenticate_user!
    
    private
    def super_user!
      unless current_user && current_user.super?
        flash[:error] = "This section requires admin priviledges!"
        redirect_to root_path
      end
    end
  end
end
