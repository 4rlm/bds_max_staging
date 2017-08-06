class AddCoordIdArrToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :coord_id_arr, :string, array: true, default: []
  end
end
