class AddColumnsToCores18 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :acct_merge_stat, :string
      add_column :cores, :acct_merge_stat_dt, :string
      add_column :cores, :cont_merge_stat, :string
      add_column :cores, :cont_merge_stat_dt, :string
  end
end
