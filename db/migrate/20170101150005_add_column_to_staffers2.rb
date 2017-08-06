class AddColumnToStaffers2 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :sfdc_tier, :string
      add_column :staffers, :domain, :string
  end
end
