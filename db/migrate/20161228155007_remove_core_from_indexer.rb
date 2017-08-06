class RemoveCoreFromIndexer < ActiveRecord::Migration[5.0]
    def change
        remove_column :indexer_staffs, :core_id, :integer
        remove_column :indexer_locations, :core_id, :integer
    end
end
