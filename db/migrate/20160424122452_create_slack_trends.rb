class CreateSlackTrends < ActiveRecord::Migration
  def change
    create_table :slack_trends do |t|
      t.integer :weekone
      t.integer :weektwo
      t.integer :weekthree
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :slack_trends, :project_id
  end
end
