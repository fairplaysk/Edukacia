class AddDefaultToSubmissionsIsRepeated < ActiveRecord::Migration
  def self.up
    change_column_default(:submissions, :is_repeated, 0)
  end

  def self.down
    change_column_default(:submissions, :is_repeated, nil)
  end
end
