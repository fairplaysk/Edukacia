class ChangeContentFromStringToTextInAnswers < ActiveRecord::Migration
  def self.up
     change_column :answers, :content, :text
  end

  def self.down
    change_column :answers, :content, :string
  end
end
