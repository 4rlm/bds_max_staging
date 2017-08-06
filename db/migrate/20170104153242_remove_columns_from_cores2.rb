class RemoveColumnsFromCores2 < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :sfdc_group_indicator, :string
      remove_column :cores, :sfdc_ult_grp_indicator, :string
  end
end
