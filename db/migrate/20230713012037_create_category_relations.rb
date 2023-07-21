class CreateCategoryRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :category_relations do |t|
      t.integer :category_id, null: false
      t.integer :episode_id, null: false

      t.timestamps
    end
    
    add_index :category_relations, [:category_id, :episode_id], unique: true
    
  end
end
