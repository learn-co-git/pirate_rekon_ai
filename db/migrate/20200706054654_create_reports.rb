class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :report_id
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :telephone_number
      t.string :incident_date
      t.text :summary
      t.references :user_id
      t.string :vehicle_urls
      t.string :image_urls
      t.text :data
    end
  end
end
