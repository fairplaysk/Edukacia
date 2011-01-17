class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :allow_destroy => true
  validates_associated :questions
  
  has_many :placement_comments, :dependent => :destroy
  accepts_nested_attributes_for :placement_comments, :allow_destroy => true
  validates_associated :placement_comments

  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  has_many :submissions
  
  has_many :additional_questions
  accepts_nested_attributes_for :additional_questions, :reject_if => lambda { |aq| aq[:name].blank? }, :allow_destroy => true
  
  has_attached_file :graphic, :styles => { :thumb => "150x150#" }
  
  validates :name, :categories, :placement_comments, :presence => true
  
  validate :question_positions_unique, :active_with_published_at
  
  def last_submission_for_session_id(session_id)
    submissions.where(:session_id => session_id).order('created_at').last
  end
  
  def question_positions_unique
    errors.add :questions, 'Positions have to be unique.' unless questions.select{|q| q.position!=99}.map(&:position).uniq!.nil?
  end
  
  def active_with_published_at
    errors.add :published_at, 'An active quiz must have a published date' if is_active? && published_at.nil?
  end
end
