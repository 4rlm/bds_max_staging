class AddColumnsToLocations3 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :sfdc_id, :string
      add_column :locations, :tier, :string
      add_column :locations, :sales_person, :string
      add_column :locations, :acct_type, :string
      add_column :locations, :location_status, :string
      add_column :locations, :rev_address, :string
      add_column :locations, :rev_street, :string
      add_column :locations, :rev_city, :string
      add_column :locations, :rev_state, :string
      add_column :locations, :rev_state_code, :string
      add_column :locations, :rev_postal_code, :string
      add_column :locations, :url, :string
      add_column :locations, :root, :string
      add_column :locations, :franchise, :string
  end
end
