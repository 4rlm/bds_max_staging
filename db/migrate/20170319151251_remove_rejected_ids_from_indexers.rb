class RemoveRejectedIdsFromIndexers < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexers, :rejected_ids, :string, array: true, default: []
  end
end
