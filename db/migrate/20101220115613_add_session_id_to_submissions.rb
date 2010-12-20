class AddSessionIdToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :session_id, :string
  end

  def self.down
    remove_column :submissions, :session_id
  end
end
