class Renameyearcolumn < ActiveRecord::Migration[6.0]
  def change
    change_column :vehicles, :year, :string
  end
end
