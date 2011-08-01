class Question < ActiveRecord::Base
  # belongs_to :quiz
  has_many :queries
  has_many :quizzes, :through => :queries
  has_one :quiz, :through => :queries, :conditions => ['queries.is_generated = ?', false]
  
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true
  validates_associated :answers
  
  has_attached_file :graphic, :styles => { :thumb => "150x150#" }
  
  validates_presence_of :content
  validate :check_correct_answer
  
  def check_correct_answer
    errors.add :answers, 'You need to select at least one correct answer for a question' if answers.select{|a| a.is_correct? == true}.count == 0
  end
  
  def correct_answer
    answers.where(:is_correct => true).first
  end
  
  def average_submission_percentage
    all_question_submissions = quizzes.map{|q| q.submissions }.flatten.select{|s| !s.is_repeated?}.length.to_f
    percentage = all_question_submissions > 0 ? (answers.select{|a| a.is_correct? }.map{|a| a.submissions}.flatten.select{|s| !s.is_repeated?}.flatten.length.to_f*100 / all_question_submissions) : 0 
    update_attribute(:average_percentage, percentage)
    percentage
  end
end
