class FixHerokuDb < ActiveRecord::Migration[5.0]
    def change
        # rename_column :indexer_locations, :loc_link, :link
        # rename_column :indexer_staffs, :staff_link, :link
        # remove_column :locations, :rev_address, :string
    end
end
