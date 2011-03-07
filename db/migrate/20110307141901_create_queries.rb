class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.references :quiz
      t.references :question
      t.boolean :is_generated, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
