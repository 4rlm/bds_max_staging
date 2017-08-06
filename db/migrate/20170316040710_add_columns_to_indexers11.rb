class AddColumnsToIndexers11 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :score100, :string, array: true, default: []
      add_column :indexers, :score75, :string, array: true, default: []
      add_column :indexers, :score50, :string, array: true, default: []
      add_column :indexers, :score25, :string, array: true, default: []
  end
end
