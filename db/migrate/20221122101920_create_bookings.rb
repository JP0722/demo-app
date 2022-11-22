class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :hotel
      t.date :from_date
      t.date :to_date
      t.integer :price_per_room
      t.integer :total_cost
      t.timestamps
    end
  end
end
