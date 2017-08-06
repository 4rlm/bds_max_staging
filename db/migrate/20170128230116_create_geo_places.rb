class CreateGeoPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :geo_places do |t|
      t.string :sfdc_id
      t.string :account
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.string :phone
      t.string :website
      t.string :map_url
      t.string :img_url
      t.string :hierarchy
      t.string :place_id
      t.string :address_components
      t.string :reference
      t.string :aspects
      t.string :reviews

      t.timestamps
    end
  end
end
