class AddColumnsToLocations23 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :sfdc_acct_pin, :string
      add_column :locations, :geo_acct_pin, :string
  end
end
