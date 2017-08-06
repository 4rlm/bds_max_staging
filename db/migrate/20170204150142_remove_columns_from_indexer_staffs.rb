class RemoveColumnsFromIndexerStaffs < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexer_staffs, :sfdc_group_name, :string
      remove_column :indexer_staffs, :sfdc_ult_acct, :string
      remove_column :indexer_staffs, :ip, :string
      remove_column :indexer_staffs, :indexer_timestamp, :datetime
  end
end
