class RemoveColumnsFromCores4 < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :sfdc_geo_addy, :string
      remove_column :cores, :sfdc_lat, :float
      remove_column :cores, :sfdc_lon, :float
      remove_column :cores, :sfdc_geo_status, :string
      remove_column :cores, :sfdc_geo_date, :datetime
      remove_column :cores, :sfdc_coordinates, :string
      remove_column :cores, :core_geo_status, :string
  end
end
