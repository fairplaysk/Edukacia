class AddShortNameToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :short_name, :string
  end

  def self.down
    remove_column :categories, :short_name
  end
end
