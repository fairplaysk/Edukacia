class Submission < ActiveRecord::Base
  has_many :choises
  has_many :answers, :through => :choises
  
  belongs_to :quiz
  
  default_scope order('updated_at desc')
  
  def correct_answers_count
    answers.collect { |answer| answer.is_correct? }.count
  end
end
