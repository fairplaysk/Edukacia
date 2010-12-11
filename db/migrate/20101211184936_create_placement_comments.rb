class CreatePlacementComments < ActiveRecord::Migration
  def self.up
    create_table :placement_comments do |t|
      t.integer :quiz_id
      t.text :content
      t.boolean :is_funny

      t.timestamps
    end
  end

  def self.down
    drop_table :placement_comments
  end
end
