class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :vin
      t.string :make
      t.string :model
      t.integer :year

      t.timestamps
    end
  end
end