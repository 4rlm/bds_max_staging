class AddColumnsToLocations18 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :geo_url_redirect, :string
  end
end
