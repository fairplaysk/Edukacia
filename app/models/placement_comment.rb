class PlacementComment < ActiveRecord::Base
  belongs_to :quiz
  
  default_scope order(:position)
end
