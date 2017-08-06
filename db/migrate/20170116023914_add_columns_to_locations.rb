class AddColumnsToLocations < ActiveRecord::Migration[5.0]
  def change
    #   add_column :locations, :address, :string
      add_column :locations, :city, :string
      add_column :locations, :state, :string
      add_column :locations, :state_code, :string
      add_column :locations, :postal_code, :string
      add_column :locations, :coordinates, :string
      add_column :locations, :location_status, :string
  end
end
