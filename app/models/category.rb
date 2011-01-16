class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :quizzes, :through => :categorizations
  
  validates_uniqueness_of :name
end
