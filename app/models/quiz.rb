class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:content].blank? }, :allow_destroy => true
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  has_many :placement_comments, :dependent => :destroy
  accepts_nested_attributes_for :placement_comments, :reject_if => lambda { |pc| pc[:content].blank? }, :allow_destroy => true
  
  has_attached_file :graphic, :styles => { :thumb => "150x150#" }
  
  validates :name, :categories, :placement_comments, :presence => true
end
