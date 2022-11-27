class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id,      null: false, default: ""
      t.integer :post_id,      null: false, default: ""
      t.datetime :check_in,    null: false, default: ""
      t.datetime :check_out,   null: false, default: ""
      t.integer :stay_count,   null: false, default: ""
      t.integer :peaple_count, null: false, default: ""
      t.integer :room_fee,     null: false, default: ""

      t.timestamps
    end
  end
end
