class CreateAdditionalQuestions < ActiveRecord::Migration
  def self.up
    create_table :additional_questions do |t|
      t.integer :quiz_id
      t.string :name
      t.string :type
      t.text :values

      t.timestamps
    end
  end

  def self.down
    drop_table :additional_questions
  end
end
