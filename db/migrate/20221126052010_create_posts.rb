class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null:false
      t.string :room_name, null:false
      t.integer :room_price, null:false
      t.text :room_info
      t.integer :room_address_postcode, null:false
      t.string :room_address_prefecture, null:false
      t.string :room_address_town_village, null:false
      t.string :room_address_other
      t.string :room_photo

      t.timestamps
    end
  end
end
