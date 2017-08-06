class AddStsColsToLocations < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :url_sts, :string
      add_column :locations, :acct_sts, :string
      add_column :locations, :addr_sts, :string
      add_column :locations, :ph_sts, :string
  end
end
