class RemoveVehicleIdFromVehicles < ActiveRecord::Migration[6.0]
  def change
    remove_column :vehicles, :vehicle_id, :integer
  end
end
