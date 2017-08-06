class AddColumnsToIndexers10 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :crm_acct_ids, :string, array: true, default: []
      add_column :indexers, :crm_ph_ids, :string, array: true, default: []
  end
end
