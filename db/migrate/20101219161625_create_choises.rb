class CreateChoises < ActiveRecord::Migration
  def self.up
    create_table :choises do |t|
      t.integer :submission_id
      t.integer :answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :choises
  end
end
