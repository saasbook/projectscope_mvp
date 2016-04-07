class RemoveGitRepoFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :git_repo, :string
  end
end
