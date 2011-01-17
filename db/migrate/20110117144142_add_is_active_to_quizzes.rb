class AddIsActiveToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :is_active, :boolean
  end

  def self.down
    remove_column :quizzes, :is_active
  end
end
