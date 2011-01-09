module Kwizzer
  class UsersController < ApplicationController
    before_filter :super_user!
    
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        redirect_to(kwizzer_user_path(@user), :notice => 'User was successfully created.') 
      else
        render :action => "new"
      end
    end

    def update
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        redirect_to(kwizzer_user_path(@user), :notice => 'User was successfully updated.')
      else
        render :action => "edit"
      end
    end
  end
end