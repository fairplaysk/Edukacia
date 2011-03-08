class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :quizzes, :through => :categorizations
  
  validates_uniqueness_of :name
  
  def active_quizzes
    quizzes.where(:is_active => true)
  end
  
  def self.order_by_popularity
    where('categories.name != ?', 'Random').joins(:quizzes => :submissions).group('submissions.quiz_id').order('count(submissions.quiz_id) desc')
  end
end
