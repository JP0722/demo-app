class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.text :address
      t.integer :rooms_count
      t.integer :price_per_room
      t.boolean :ac
      t.boolean :wifi
      t.boolean :parking
      t.belongs_to :user
      t.timestamps
    end
  end
end
