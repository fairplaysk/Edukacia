class Quiz < ActiveRecord::Base
  has_many :queries
  has_many :questions, :dependent => :destroy, :through => :queries do
    def push_with_attributes(question, join_attrs)
      Query.send(:with_scope, :create => join_attrs) { self << question }
    end
  end
  accepts_nested_attributes_for :questions, :allow_destroy => true
  validates_associated :questions
  
  has_many :placement_comments, :dependent => :destroy
  accepts_nested_attributes_for :placement_comments, :allow_destroy => true
  validates_associated :placement_comments

  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  has_many :submissions
  has_many :first_submissions, :class_name => 'Submission', :conditions => {:is_repeated => false}
  
  has_many :additional_questions
  accepts_nested_attributes_for :additional_questions, :reject_if => lambda { |aq| aq[:name].blank? }, :allow_destroy => true
  
  has_attached_file :graphic, :styles => { :thumb => "150x150#" }
  
  validates :name, :categories, :placement_comments, :presence => true, :unless => :is_generated?
  
  validate :question_positions_unique, :active_with_published_at
  
  after_save :update_placement_comments_positions
  def update_placement_comments_positions
    if placement_comments.present?
      placement_comments.each_with_index do |placement_comment, index|
        placement_comment.update_attribute(:position, index)
      end
    end
  end
  
  def last_submission_for_session_id(session_id)
    submissions.where(:session_id => session_id).order('created_at').last
  end
  
  def question_positions_unique
    errors.add :questions, 'Positions have to be unique.' unless questions.select{|q| q.position!=99}.map(&:position).uniq!.nil?
  end
  
  def active_with_published_at
    errors.add :published_at, 'An active quiz must have a published date' if is_active? && published_at.nil?
  end
  
  def questions_for_page(page)
    if page <= questions.length/questions_per_page
      questions[((page-1)*questions_per_page)...(page*questions_per_page)]
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
  def quiz_submission_percentage
    correct_answers_count = questions.map{|q| q.answers }.flatten.select{|a| a.is_correct? }.map{|a| a.submissions}.flatten.select{|s| !s.is_repeated?}.length.to_f
    all_answers_count = questions.map{|q| q.quizzes.includes(:submissions) }.flatten.map{|q| q.submissions }.flatten.select{|s| !s.is_repeated? }.length.to_f
    all_answers_count > 0 ? correct_answers_count*100 / all_answers_count : 0
  end
end
