class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :visibility, null: false, default: 0
      t.integer :group_id

      t.timestamps
    end
  end
end
