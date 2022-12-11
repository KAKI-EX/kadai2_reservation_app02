class RenamePeapleColumnToReservations < ActiveRecord::Migration[6.0]
  def change
    rename_column :reservations, :peaple_count, :people_count
  end
end
