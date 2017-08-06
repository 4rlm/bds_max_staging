class RemoveColumnsFromCores < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :verified_ult_rt_indicator, :string
      remove_column :cores, :verified_grp_rt_indicator, :string
      remove_column :cores, :sfdc_franch_indicator, :string
      remove_column :cores, :site_franch_indicator, :string
      remove_column :cores, :franchise, :string
  end
end
