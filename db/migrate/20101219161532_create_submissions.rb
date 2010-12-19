class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.boolean :is_repeated

      t.timestamps
    end
  end

  def self.down
    drop_table :submissions
  end
end
