class RenameWrongDataTypeCols < ActiveRecord::Migration[5.0]
    def change
        rename_column :in_host_pos, :brand_count, :brand_count_old
        rename_column :in_host_pos, :cat_count, :cat_count_old

        rename_column :indexer_terms, :criteria_count, :criteria_count_old
        rename_column :indexer_terms, :response_count, :response_count_old

        rename_column :indexers, :contacts_count, :contacts_count_old

        rename_column :dashboards, :col_total, :col_total_old
        rename_column :dashboards, :item_list_total, :item_list_total_old
    end
end
