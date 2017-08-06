class AddColumnsToLocations17 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :crm_url_redirect, :string
  end
end
