class AddColumnsToCores20 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_ult_rt, :string
      add_column :cores, :sfdc_grp_rt, :string
      add_column :cores, :sfdc_zip, :string
  end
end
