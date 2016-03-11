class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.integer :red
      t.integer :yellow
      t.integer :green
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :pull_requests, :project_id
  end
end
