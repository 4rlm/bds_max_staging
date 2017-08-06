class DropUnusedTables < ActiveRecord::Migration[5.0]
  def change
      drop_table :criteria_indexer_staff_texts
      drop_table :criteria_indexer_loc_hrefs
      drop_table :geo_places
      drop_table :indexer_locations
      drop_table :indexer_staffs
  end
end
