class AddIsGeneratedToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :is_generated, :boolean, :default => false
  end

  def self.down
    remove_column :quizzes, :is_generated
  end
end
