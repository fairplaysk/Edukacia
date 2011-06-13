class AddRatingToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :rating, :integer
  end

  def self.down
    remove_column :submissions, :rating
  end
end
