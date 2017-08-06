class AddColumnsToCores3 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :grp_name_indicator, :string
      add_column :cores, :ult_grp_name_indicator, :string
      add_column :cores, :tier_indicator, :string
      add_column :cores, :site_tier, :string
      add_column :cores, :site_franch_cat, :string
      add_column :cores, :sfdc_franch_cat, :string
  end
end
