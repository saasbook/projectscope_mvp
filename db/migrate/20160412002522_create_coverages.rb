class CreateCoverages < ActiveRecord::Migration
  def change
    create_table :coverages do |t|
      t.float :score
      t.string :url
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :coverages, :project_id
  end
end
