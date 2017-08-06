class AddColumnsToCores16 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :cop_lat, :string
      add_column :cores, :cop_lon, :string
      add_column :cores, :cop_coordinates, :string
      add_column :cores, :cop_template, :string
      add_column :cores, :cop_franch, :string
      add_column :cores, :conf_cat, :string
      add_column :cores, :lock, :string
  end
end
