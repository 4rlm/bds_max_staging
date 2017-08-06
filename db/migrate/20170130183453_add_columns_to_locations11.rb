class AddColumnsToLocations11 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :crm_hierarchy, :string
  end
end
