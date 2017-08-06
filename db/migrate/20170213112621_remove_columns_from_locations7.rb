class RemoveColumnsFromLocations7 < ActiveRecord::Migration[5.0]
  def change
      remove_column :locations, :acct_merge_stat_dt, :string
      remove_column :locations, :acct_merge_stat, :string
      remove_column :locations, :crm_hierarchy, :string
      remove_column :locations, :hierarchy, :string
  end
end
