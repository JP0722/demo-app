class DeleteTotalRoomsColumnFromHotels < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotels, :rooms_count
  end
end
