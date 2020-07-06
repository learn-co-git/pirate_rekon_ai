class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.integer :vehicle_id
      t.string :make
      t.string :model
      t.integer :year
      t.string :plate
      t.string :color
      t.text :background
      t.references :user_id
      t.timestamps
    end
  end
end
