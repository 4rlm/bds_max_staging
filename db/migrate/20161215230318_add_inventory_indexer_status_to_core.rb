class AddInventoryIndexerStatusToCore < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :inventory_indexer_status, :string
  end
end
