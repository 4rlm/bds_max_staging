class AddColumnsToCores6 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_geo_status, :string
      add_column :cores, :site_geo_status, :string
      add_column :cores, :sfdc_geo_date, :datetime
      add_column :cores, :site_geo_date, :datetime
      add_column :cores, :sfdc_coordinates, :string
      add_column :cores, :site_coordinates, :string
  end
end
