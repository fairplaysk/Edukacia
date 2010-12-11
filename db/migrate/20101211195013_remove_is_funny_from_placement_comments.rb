class RemoveIsFunnyFromPlacementComments < ActiveRecord::Migration
  def self.up
    remove_column :placement_comments, :is_funny
  end

  def self.down
    add_column :placement_comments, :is_funny, :boolean
  end
end
