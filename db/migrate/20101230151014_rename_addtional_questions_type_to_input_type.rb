class RenameAddtionalQuestionsTypeToInputType < ActiveRecord::Migration
  def self.up
    rename_column :additional_questions, :type, :input_type
  end

  def self.down
    rename_column :additional_questions, :input_type, :type
  end
end
