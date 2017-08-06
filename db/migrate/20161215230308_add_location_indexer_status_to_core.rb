class AddLocationIndexerStatusToCore < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :location_indexer_status, :string
  end
end
