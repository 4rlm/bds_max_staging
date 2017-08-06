class RemoveColumnsFromStaffers2 < ActiveRecord::Migration[5.0]
  def change
      remove_column :staffers, :sfdc_acct_url, :string
  end
end
