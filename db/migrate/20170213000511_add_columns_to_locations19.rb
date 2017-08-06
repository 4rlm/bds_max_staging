class AddColumnsToLocations19 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :sts_geo_crm, :string
      add_column :locations, :sts_url, :string
      add_column :locations, :sts_root, :string
      add_column :locations, :sts_acct, :string
      add_column :locations, :sts_addr, :string
      add_column :locations, :sts_ph, :string  
  end
end
