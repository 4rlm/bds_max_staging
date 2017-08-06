class RemoveColumnsFromCores6 < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :acct_pin, :string
      remove_column :cores, :sfdc_url_redirect, :string
      remove_column :cores, :lock, :string
      remove_column :cores, :hierarchy, :string
      remove_column :cores, :whois_date, :string
      remove_column :cores, :sfdc_root, :string
      remove_column :cores, :inventory_indexer_status, :string
      remove_column :cores, :url_status, :string
  end
end
