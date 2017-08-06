class AddColumsToCoresAndIndexers < ActiveRecord::Migration[5.0]
    def change
        add_column :cores, :crm_staff_count, :integer, default: 0
        add_column :cores, :web_staff_count, :integer, default: 0

        add_column :indexers, :crm_staff_count, :integer, default: 0
        rename_column :indexers, :staff_count, :web_staff_count
    end
end
