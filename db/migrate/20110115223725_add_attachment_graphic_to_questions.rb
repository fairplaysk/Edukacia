class AddAttachmentGraphicToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :graphic_file_name, :string
    add_column :questions, :graphic_content_type, :string
    add_column :questions, :graphic_file_size, :integer
    add_column :questions, :graphic_updated_at, :datetime
  end

  def self.down
    remove_column :questions, :graphic_file_name
    remove_column :questions, :graphic_content_type
    remove_column :questions, :graphic_file_size
    remove_column :questions, :graphic_updated_at
  end
end
