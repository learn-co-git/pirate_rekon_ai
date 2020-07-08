class AddUrlToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :url, :string
  end
end
