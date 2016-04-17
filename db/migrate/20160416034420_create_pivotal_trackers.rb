class CreatePivotalTrackers < ActiveRecord::Migration
  def change
    create_table :pivotal_trackers do |t|
      t.integer :done
      t.integer :new
      t.integer :old
      t.integer :older
      t.integer :tracker_id
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :pivotal_trackers, :project_id
  end
end