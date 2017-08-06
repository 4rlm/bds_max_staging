class AddColumnsToLocations21 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :url_arr, :string, array: true, default: []
      add_column :locations, :duplicate_arr, :string, array: true, default: []
      add_column :locations, :cop_franch_arr, :string, array: true, default: []
  end
end
