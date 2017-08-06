class SetDefaultValueForIntegerCols < ActiveRecord::Migration[5.0]
    def up
        change_column :in_host_pos, :brand_count, :integer, default: 0
        change_column :in_host_pos, :cat_count, :integer, default: 0

        change_column :indexer_terms, :criteria_count, :integer, default: 0
        change_column :indexer_terms, :response_count, :integer, default: 0

        change_column :indexers, :contacts_count, :integer, default: 0

        change_column :dashboards, :col_total, :integer, default: 0
        change_column :dashboards, :item_list_total, :integer, default: 0
    end
    
    def down
        change_column :in_host_pos, :brand_count, :integer, default: nil
        change_column :in_host_pos, :cat_count, :integer, default: nil

        change_column :indexer_terms, :criteria_count, :integer, default: nil
        change_column :indexer_terms, :response_count, :integer, default: nil

        change_column :indexers, :contacts_count, :integer, default: nil

        change_column :dashboards, :col_total, :integer, default: nil
        change_column :dashboards, :item_list_total, :integer, default: nil
    end
end
