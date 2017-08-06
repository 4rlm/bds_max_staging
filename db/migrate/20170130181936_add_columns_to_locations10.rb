class AddColumnsToLocations10 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :crm_phone, :string
  end
end
