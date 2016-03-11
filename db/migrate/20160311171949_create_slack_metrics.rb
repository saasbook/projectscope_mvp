class CreateSlackMetrics < ActiveRecord::Migration
  def change
    create_table :slack_metrics do |t|
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :slack_metrics, :project_id
  end
end
