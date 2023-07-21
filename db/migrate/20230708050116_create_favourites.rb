class CreateFavourites < ActiveRecord::Migration[6.1]
  def change
    create_table :favourites do |t|
      t.integer :user_id, null: false
      t.integer :episode_id, null: false

      t.timestamps
    end
  end
end
