class AddResetPinColumToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reset_pin, :integer
  end
end
