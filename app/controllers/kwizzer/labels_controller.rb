module Kwizzer
  class LabelsController < ApplicationController
    respond_to :html
  
    before_filter :super_user!

    def index
      @labels = Label.all
      respond_with @labels
    end

    def show
      @label = Label.find(params[:id])
      respond_with @label
    end


    def new
      @label = Label.new
      respond_with @label
    end

    def edit
      @label = Label.find(params[:id])
    end

    def create
      @label = Label.new(params[:label])
      flash[:notice] = 'Label was successfully created.' if @label.save
      respond_with @label, :location => kwizzer_labels_path
    end

    def update
      @label = Label.find(params[:id])
      flash[:notice] = 'Label was successfully updated.' if @label.update_attributes(params[:label])
      respond_with @label, :location => kwizzer_labels_path
    end

    def destroy
      @label = Label.find(params[:id])
      @label.destroy
      respond_with @label, :location => kwizzer_labels_path
    end
  end
end