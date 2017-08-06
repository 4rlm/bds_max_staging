class AddColumnsToIndexers2 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :contact_status, :string
  end
end
