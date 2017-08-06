class AddColumnsToIndexers7 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :geo_status, :string
  end
end
