class AddColumnsToCores12 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :full_address, :string
      add_column :cores, :latitude, :float
      add_column :cores, :longitude, :float
      add_column :cores, :core_geo_status, :string
      add_column :cores, :geo_date, :datetime
      add_column :cores, :coordinates, :string
  end
end
