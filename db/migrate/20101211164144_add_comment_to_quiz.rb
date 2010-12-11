class AddCommentToQuiz < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :comment, :text
  end

  def self.down
    remove_column :quizzes, :comment
  end
end
