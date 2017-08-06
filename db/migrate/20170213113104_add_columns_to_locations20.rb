class AddColumnsToLocations20 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :sts_duplicate, :string      
  end
end
