class AddColumnsToStaffers7 < ActiveRecord::Migration[5.0]
  def change
    add_column :staffers, :scrape_date, :datetime
  end
end
