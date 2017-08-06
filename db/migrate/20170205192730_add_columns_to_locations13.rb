class AddColumnsToLocations13 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :sfdc_acct_url, :string
  end
end
