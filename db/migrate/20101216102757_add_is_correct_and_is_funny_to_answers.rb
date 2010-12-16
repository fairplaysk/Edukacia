class AddIsCorrectAndIsFunnyToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :is_correct, :boolean
    add_column :answers, :is_funny, :boolean
  end

  def self.down
    remove_column :answers, :is_funny
    remove_column :answers, :is_correct
  end
end
