class AddColumnsToIndexers6 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :who_status, :string
  end
end
