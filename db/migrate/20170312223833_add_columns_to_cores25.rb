class AddColumnsToCores25 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :acct_match_score, :string
      add_column :cores, :org_match_status, :string
      add_column :cores, :ph_match_status, :string
      add_column :cores, :pin_match_status, :string
      add_column :cores, :url_match_status, :string
  end
end
