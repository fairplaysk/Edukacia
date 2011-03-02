class AddPositionToPlacementComments < ActiveRecord::Migration
  def self.up
    add_column :placement_comments, :position, :integer
  end

  def self.down
    remove_column :placement_comments, :position
  end
end
