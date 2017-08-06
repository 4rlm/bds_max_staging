class AddColumnsToLocations6 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :franch_cat, :string
  end
end
