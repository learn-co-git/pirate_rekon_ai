class AddPublicIdToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :public_id, :string
  end
end
