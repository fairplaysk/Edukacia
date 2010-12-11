class AddFunnyCommentToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :funny_comment, :text
  end

  def self.down
    remove_column :quizzes, :funny_comment
  end
end
