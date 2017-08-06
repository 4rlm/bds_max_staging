class AddColumnsToIndexers9 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :clean_url_crm_ids, :string, array: true, default: []
      add_column :indexers, :acct_pin_crm_ids, :string, array: true, default: []
  end
end
