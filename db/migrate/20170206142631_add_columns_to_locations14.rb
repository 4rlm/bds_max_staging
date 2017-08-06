class AddColumnsToLocations14 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :acct_merge_stat, :string
      add_column :locations, :acct_merge_stat_dt, :string
  end
end
