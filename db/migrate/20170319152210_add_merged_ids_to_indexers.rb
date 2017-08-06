class AddMergedIdsToIndexers < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :merged_ids, :string, array: true, default: []
  end
end
