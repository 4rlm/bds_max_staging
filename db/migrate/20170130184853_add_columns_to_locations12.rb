class AddColumnsToLocations12 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :geo_type, :string
  end
end
