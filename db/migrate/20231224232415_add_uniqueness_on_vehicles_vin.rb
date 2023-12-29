class AddUniquenessOnVehiclesVin < ActiveRecord::Migration[7.1]
  def change
    change_column_null :vehicles, :vin, false
    add_index :vehicles, :vin, unique: true
  end
end
