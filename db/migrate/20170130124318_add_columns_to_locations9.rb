class AddColumnsToLocations9 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :crm_source, :string
      add_column :locations, :geo_root, :string
      add_column :locations, :crm_root, :string
      add_column :locations, :crm_url, :string
      add_column :locations, :geo_franch_term, :string
      add_column :locations, :geo_franch_cons, :string
      add_column :locations, :geo_franch_cat, :string
      add_column :locations, :crm_franch_term, :string
      add_column :locations, :crm_franch_cons, :string
      add_column :locations, :crm_franch_cat, :string
  end
end
