class AddTotalToPivotalTrackers < ActiveRecord::Migration
  def change
    add_column :pivotal_trackers, :total, :integer
  end
end
