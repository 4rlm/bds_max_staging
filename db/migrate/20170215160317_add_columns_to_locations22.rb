class AddColumnsToLocations22 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :cop_franch, :string
  end
end
