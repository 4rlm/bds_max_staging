class AddStaffIndexerStatusToCore < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :staff_indexer_status, :string
  end
end
