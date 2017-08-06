class AddColumnsToLocations7 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :hierarchy, :string
  end
end
