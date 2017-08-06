class AddAcctMergeStsToCores < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :acct_merge_sts, :string
  end
end
