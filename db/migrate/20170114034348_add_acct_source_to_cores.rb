class AddAcctSourceToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :acct_source, :string
  end
end
