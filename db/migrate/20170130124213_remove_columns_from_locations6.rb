class RemoveColumnsFromLocations6 < ActiveRecord::Migration[5.0]
  def change
      remove_column :locations, :root, :string
      remove_column :locations, :franchise, :string
      remove_column :locations, :franch_cat, :string
      remove_column :locations, :reference, :string
      remove_column :locations, :aspects, :string
      remove_column :locations, :address_components, :string
  end
end
