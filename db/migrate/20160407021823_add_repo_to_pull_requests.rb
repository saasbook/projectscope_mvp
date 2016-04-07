class AddRepoToPullRequests < ActiveRecord::Migration
  def change
    add_column :pull_requests, :repo, :string
  end
end
