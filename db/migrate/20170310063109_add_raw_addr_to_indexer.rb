class AddRawAddrToIndexer < ActiveRecord::Migration[5.0]
  def change
    add_column :indexers, :raw_addr, :string
    add_column :indexers, :raw_street, :string
  end
end
