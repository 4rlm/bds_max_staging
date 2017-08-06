class DropCriteriaTables2 < ActiveRecord::Migration[5.0]
  def change
      drop_table :criteria_indexer_staff_hrefs
      drop_table :criteria_indexer_loc_texts
  end
end
