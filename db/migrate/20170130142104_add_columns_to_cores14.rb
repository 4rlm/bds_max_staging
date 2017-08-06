class AddColumnsToCores14 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :geo_full_address, :string
      add_column :cores, :geo_acct_name, :string
  end
end
