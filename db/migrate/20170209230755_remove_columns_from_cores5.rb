class RemoveColumnsFromCores5 < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :sfdc_ult_rt, :integer
      remove_column :cores, :sfdc_grp_rt, :integer
      remove_column :cores, :sfdc_zip, :integer
  end
end
