class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.string :plate
      t.string :color
      t.text :background
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
