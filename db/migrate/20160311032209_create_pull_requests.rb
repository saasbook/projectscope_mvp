class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.integer :red
      t.integer :yellow
      t.integer :green

      t.timestamps null: false
    end
  end
end
