class FixColumnNameImages < ActiveRecord::Migration[6.0]
  def self.up
   rename_column :images, :user_id_id, :user_id
 end

 def self.down

 end
end
