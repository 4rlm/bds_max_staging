class RenameColsInDashboards < ActiveRecord::Migration[5.0]
    def change
        rename_column :dashboards, :db_internal, :db_name
        rename_column :dashboards, :db_public, :db_alias
        rename_column :dashboards, :column_internal, :col_name
        rename_column :dashboards, :column_public, :col_alias
        rename_column :dashboards, :column_item_count, :col_total
        rename_column :dashboards, :column_uniq_items, :item_list
        rename_column :dashboards, :column_uniq_item_count, :item_list_total

        remove_column :dashboards, :db_count, :string
    end
end
