class RemoveWrongDataTypeCols < ActiveRecord::Migration[5.0]
    def change
        remove_column :in_host_pos, :brand_count_old, :string
        remove_column :in_host_pos, :cat_count_old, :string

        remove_column :indexer_terms, :criteria_count_old, :string
        remove_column :indexer_terms, :response_count_old, :string

        remove_column :indexers, :contacts_count_old, :string

        remove_column :dashboards, :col_total_old, :string
        remove_column :dashboards, :item_list_total_old, :string
    end
end
