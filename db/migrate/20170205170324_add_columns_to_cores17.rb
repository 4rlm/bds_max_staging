class AddColumnsToCores17 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_acct_url, :string
      add_column :cores, :sfdc_ult_grp_id, :string
      add_column :cores, :sfdc_group_id, :string
      add_column :cores, :geo_street, :string
      add_column :cores, :geo_city, :string
      add_column :cores, :geo_state, :string
      add_column :cores, :geo_zip, :string
      add_column :cores, :geo_ph, :string
      add_column :cores, :geo_url, :string
  end
end
