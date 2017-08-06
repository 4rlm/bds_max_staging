class RemoveUnusedCols < ActiveRecord::Migration[5.0]
    def change
        remove_column :cores, :domainer_date, :datetime
    end
end
