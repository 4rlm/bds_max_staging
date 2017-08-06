class AddColumnsToIndexers13 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :flagged_ids, :string, array: true, default: []
      add_column :indexers, :dropped_ids, :string, array: true, default: []
      add_column :indexers, :reported, :string
      add_column :indexers, :report_note, :string
      add_column :indexers, :cop_type, :string
      add_column :indexers, :cop_franchises, :string, array: true, default: []
  end
end
