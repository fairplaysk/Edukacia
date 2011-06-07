class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.string :identifier
      t.text :content
      t.string :language

      t.timestamps
    end
    
    add_index :labels, :identifier
    add_index :labels, :language
  end

  def self.down
    drop_table :labels
  end
end
