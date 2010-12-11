class AddSponsorToQuizzes < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :sponsor, :string
  end

  def self.down
    remove_column :quizzes, :sponsor
  end
end
