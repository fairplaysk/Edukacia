class ChangeSubmissionRatingDefault < ActiveRecord::Migration
  def self.up
    change_column_default(:submissions, :rating, 0)
    
    Submission.where(:rating => nil).update_all(:rating => 0)
  end

  def self.down
    change_column_default(:submissions, :rating, nil)
    Submission.where(:rating => 0).update_all(:rating => nil)
  end
end
