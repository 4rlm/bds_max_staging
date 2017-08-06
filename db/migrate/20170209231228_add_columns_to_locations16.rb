class AddColumnsToLocations16 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :crm_street, :string
      add_column :locations, :crm_city, :string
      add_column :locations, :crm_state, :string
      add_column :locations, :crm_zip, :string      
  end
end
