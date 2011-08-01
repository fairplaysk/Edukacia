class AddAveragePercentageToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :average_percentage, :float
  end

  def self.down
    remove_column :questions, :average_percentage
  end
end
