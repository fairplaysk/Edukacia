class AddRandomEnabledToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :random_enabled, :boolean
  end

  def self.down
    remove_column :questions, :random_enabled
  end
end
