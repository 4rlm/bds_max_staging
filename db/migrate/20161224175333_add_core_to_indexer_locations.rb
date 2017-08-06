class AddCoreToIndexerLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :indexer_locations, :core_id, :integer
    add_index :indexer_locations, :core_id
  end
end
