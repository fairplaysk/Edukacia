class AddSuperToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :super, :boolean
  end

  def self.down
    remove_column :users, :super
  end
end
