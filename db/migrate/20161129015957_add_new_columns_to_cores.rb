class AddNewColumnsToCores < ActiveRecord::Migration[5.0]
  def change
        add_column :cores, :core_date, :datetime
        add_column :cores, :domainer_date, :datetime
        add_column :cores, :indexer_date, :datetime
        add_column :cores, :staffer_date, :datetime
        add_column :cores, :whois_date, :datetime
  end
end
