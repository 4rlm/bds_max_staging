class RemoveColumnsFromCores7 < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :domain_status, :string
      remove_column :cores, :temporary_id, :string
      remove_column :cores, :cop_lat, :string
      remove_column :cores, :cop_lon, :string
      remove_column :cores, :cop_coordinates, :string
      remove_column :cores, :cop_template, :string
      remove_column :cores, :geo_street, :string
      remove_column :cores, :geo_city, :string
      remove_column :cores, :geo_state, :string
      remove_column :cores, :geo_zip, :string
      remove_column :cores, :geo_ph, :string
      remove_column :cores, :geo_url, :string
      remove_column :cores, :acct_merge_stat, :string
      remove_column :cores, :acct_merge_stat_dt, :string
      remove_column :cores, :cont_merge_stat, :string
      remove_column :cores, :cont_merge_stat_dt, :string
      remove_column :cores, :web_phones, :string
      remove_column :cores, :web_acct_pin, :string











  end
end
