class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :username
      t.text :location
      t.text :incident
      t.string :image_urls
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
