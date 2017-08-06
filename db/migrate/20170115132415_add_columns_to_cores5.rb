class AddColumnsToCores5 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_geo_addy, :string
      add_column :cores, :sfdc_lat, :float
      add_column :cores, :sfdc_lon, :float
      add_column :cores, :site_geo_addy, :string
      add_column :cores, :site_lat, :float
      add_column :cores, :site_lon, :float
  end
end
