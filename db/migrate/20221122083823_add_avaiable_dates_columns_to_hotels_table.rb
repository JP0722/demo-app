class AddAvaiableDatesColumnsToHotelsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :available_from_date, :date
    add_column :hotels, :available_to_date, :date
  end
end
