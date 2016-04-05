class CreateSlackDataPoints < ActiveRecord::Migration
  def change
    create_table :slack_data_points do |t|
      t.string :user
      t.integer :messages
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :slack_data_points, :project_id
  end
end
