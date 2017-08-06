class AddColumnsToLocations5 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :address, :string
  end
end
