class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true
  validates_associated :answers
  
  has_attached_file :graphic, :styles => { :thumb => "150x150#" }
end
