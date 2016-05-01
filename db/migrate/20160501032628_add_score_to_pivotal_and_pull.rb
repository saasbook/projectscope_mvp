class AddScoreToPivotalAndPull < ActiveRecord::Migration
  def change
    add_column :pivotal_trackers, :score, :float
    add_column :pull_requests, :score, :float
  end
end
