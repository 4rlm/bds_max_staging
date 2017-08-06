class RemoveRawAddrFromIndexers < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexers, :raw_addr, :string
  end
end
