class AddArchiveToIndexers < ActiveRecord::Migration[5.0]
  def change
    add_column :indexers, :archive, :boolean, default: false
  end
end
