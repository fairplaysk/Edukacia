class AddCommentToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :comment, :text
  end

  def self.down
    remove_column :questions, :comment
  end
end
