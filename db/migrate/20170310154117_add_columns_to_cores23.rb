class AddColumnsToCores23 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_clean_url, :string
      add_column :cores, :crm_acct_pin, :string
      add_column :cores, :web_acct_pin, :string
      add_column :cores, :crm_phones, :string, array: true, default: []
      add_column :cores, :web_phones, :string, array: true, default: []
  end
end
