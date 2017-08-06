class AddColumnsToIndexers5 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :acct_pin, :string
  end
end
