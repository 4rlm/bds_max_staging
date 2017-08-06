class AddColumnsToStaffers4 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :sfdc_acct_url, :string
  end
end
