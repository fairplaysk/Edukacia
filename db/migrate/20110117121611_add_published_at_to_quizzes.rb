class AddPublishedAtToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :published_at, :timestamp
  end

  def self.down
    remove_column :quizzes, :published_at
  end
end
