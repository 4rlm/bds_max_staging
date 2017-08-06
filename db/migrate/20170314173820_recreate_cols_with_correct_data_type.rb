class RecreateColsWithCorrectDataType < ActiveRecord::Migration[5.0]
    def change
        add_column :in_host_pos, :brand_count, :integer
        add_column :in_host_pos, :cat_count, :integer

        add_column :indexer_terms, :criteria_count, :integer
        add_column :indexer_terms, :response_count, :integer

        add_column :indexers, :contacts_count, :integer

        add_column :dashboards, :col_total, :integer
        add_column :dashboards, :item_list_total, :integer
    end
end
