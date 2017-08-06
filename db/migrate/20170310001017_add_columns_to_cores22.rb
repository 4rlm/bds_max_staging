class AddColumnsToCores22 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :acct_pin, :string
  end
end
