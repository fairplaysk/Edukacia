class Submission < ActiveRecord::Base
  has_many :choises
  has_many :answers, :through => :choises
end
