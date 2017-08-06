class AddCoreToIndexerStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :indexer_staffs, :core_id, :integer
    add_index :indexer_staffs, :core_id
  end
end
