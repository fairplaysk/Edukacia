class Answer < ActiveRecord::Base
  belongs_to :question
  
  has_many :choises
  has_many :submissions, :through => :choises
  
  validates_presence_of :content
  
  def to_s
    read_attribute :content
  end
end
