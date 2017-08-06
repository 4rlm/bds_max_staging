class AddColumnsToIndexers14 < ActiveRecord::Migration[5.0]
  def change
    add_column :indexers, :scrape_date, :datetime
  end
end
