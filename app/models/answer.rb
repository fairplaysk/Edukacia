class Answer < ActiveRecord::Base
  belongs_to :question
  
  has_many :choises
  has_many :submissions, :through => :choises
  
  validates :content, :length => {:minimum => 1, :maximum => 1000}, :presence => true
  
  def to_s
    read_attribute :content
  end
end
