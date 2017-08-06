class AddColumnsToLocations8 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :temporary_id, :string
      add_column :locations, :geo_acct_name, :string
      add_column :locations, :geo_full_addr, :string
      add_column :locations, :phone, :string
      add_column :locations, :map_url, :string
      add_column :locations, :img_url, :string
      add_column :locations, :place_id, :string
      add_column :locations, :reference, :string
      add_column :locations, :aspects, :string
      add_column :locations, :address_components, :string
  end
end
