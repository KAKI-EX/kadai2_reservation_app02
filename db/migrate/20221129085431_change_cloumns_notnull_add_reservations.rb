class ChangeCloumnsNotnullAddReservations < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :total_fee, :integer, null: false
  end
end
