class AddColumnsToIndexers12 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :rejected_ids, :string, array: true, default: []
  end
end
