class AddQuestionPerPageToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :questions_per_page, :integer
  end

  def self.down
    remove_column :quizzes, :questions_per_page
  end
end
