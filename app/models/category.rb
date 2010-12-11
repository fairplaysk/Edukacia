class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :quizzes, :through => :categorizations
end
