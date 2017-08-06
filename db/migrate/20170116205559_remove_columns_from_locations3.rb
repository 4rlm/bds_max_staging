class RemoveColumnsFromLocations3 < ActiveRecord::Migration[5.0]
  def change
    remove_column :locations, :address, :string
  end
end
