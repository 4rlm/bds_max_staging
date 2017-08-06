class RemoveArchivedFromIndexers < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexers, :archived, :string
  end
end
