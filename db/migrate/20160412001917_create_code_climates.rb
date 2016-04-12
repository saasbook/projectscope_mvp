class CreateCodeClimates < ActiveRecord::Migration
  def change
    create_table :code_climates do |t|
      t.float :score
      t.string :url
      t.integer :project_id

      t.timestamps null: false
    end
    
    add_index :code_climates, :project_id
  end
end
