class AddAveragePercentageToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :average_percentage, :float
  end

  def self.down
    remove_column :quizzes, :average_percentage
  end
end
