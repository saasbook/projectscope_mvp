class AddTotalToPullRequests < ActiveRecord::Migration
  def change
    add_column :pull_requests, :total, :integer
  end
end
