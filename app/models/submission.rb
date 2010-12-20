class Submission < ActiveRecord::Base
  has_many :choises
  has_many :answers, :through => :choises
  
  belongs_to :quiz
  
  def correct_answers_count
    answers.collect { |answer| answer.is_correct? }.count
  end
end
