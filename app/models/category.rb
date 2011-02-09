class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :quizzes, :through => :categorizations
  
  validates_uniqueness_of :name
  
  def active_quizzes
    quizzes.where(:is_active => true)
  end
end
