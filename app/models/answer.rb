class Answer < ActiveRecord::Base
  belongs_to :question
  
  has_many :choises
  has_many :submissions, :through => :choises
  
  def to_s
    read_attribute :content
  end
end
