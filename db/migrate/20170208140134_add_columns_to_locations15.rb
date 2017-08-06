class AddColumnsToLocations15 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :street_num, :string
      add_column :locations, :street_text, :string      
  end
end
