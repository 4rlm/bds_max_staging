class RemoveColumnsFromIndexerLocations < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexer_locations, :sfdc_group_name, :string
      remove_column :indexer_locations, :sfdc_ult_acct, :string
      remove_column :indexer_locations, :ip, :string
      remove_column :indexer_locations, :indexer_timestamp, :datetime
  end
end
