class AddColumnsToCores < ActiveRecord::Migration[5.0]
    def change
        add_column :cores, :staff_link, :string
        add_column :cores, :staff_text, :string
        add_column :cores, :location_link, :string
        add_column :cores, :location_text, :string
    end
end
