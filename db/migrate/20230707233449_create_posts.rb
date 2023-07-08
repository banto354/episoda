class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :visibility, null: false, default: 0
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
