class AddColumnsToDashboards1 < ActiveRecord::Migration[5.0]
  def change
      add_column :dashboards, :db_internal, :string
      add_column :dashboards, :db_public, :string
      add_column :dashboards, :db_count, :string
      add_column :dashboards, :column_internal, :string
      add_column :dashboards, :column_public, :string
      add_column :dashboards, :column_item_count, :string
      add_column :dashboards, :column_uniq_items, :string, array: true, default: []
      add_column :dashboards, :column_uniq_item_count, :string
  end
end
