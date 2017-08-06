class AddColumnToStaffers < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :sfdc_cont_active, :integer
  end
end
