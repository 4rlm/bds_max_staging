class AddColumnsToIndexers8 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :archived, :string
  end
end
