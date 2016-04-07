class CreateSlackDataPoints < ActiveRecord::Migration
  def change
    create_table :slack_data_points do |t|
      t.string :user
      t.integer :messages
      t.integer :slack_metric_id

      t.timestamps null: false
    end
    
    add_index :slack_data_points, :slack_metric_id
  end
end
