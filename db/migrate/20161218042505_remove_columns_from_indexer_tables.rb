class RemoveColumnsFromIndexerTables < ActiveRecord::Migration[5.0]
    def change
        remove_column :indexer_locations, :sfdc_street, :string
        remove_column :indexer_locations, :sfdc_city, :string
        remove_column :indexer_locations, :sfdc_state, :string
        remove_column :indexer_locations, :sfdc_type, :string
        remove_column :indexer_locations, :sfdc_tier, :string
        remove_column :indexer_locations, :sfdc_sales_person, :string
        remove_column :indexer_locations, :root, :string
        remove_column :indexer_locations, :msg, :string
        remove_column :indexer_staffs, :sfdc_street, :string
        remove_column :indexer_staffs, :sfdc_city, :string
        remove_column :indexer_staffs, :sfdc_state, :string
        remove_column :indexer_staffs, :sfdc_type, :string
        remove_column :indexer_staffs, :sfdc_tier, :string
        remove_column :indexer_staffs, :sfdc_sales_person, :string
        remove_column :indexer_staffs, :root, :string
        remove_column :indexer_staffs, :msg, :string
    end
end
