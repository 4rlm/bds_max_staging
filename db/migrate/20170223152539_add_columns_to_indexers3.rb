class AddColumnsToIndexers3 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :contacts_count, :string
      add_column :indexers, :contacts_link, :string
  end
end
