class RemoveColumnsFromStaffers3 < ActiveRecord::Migration[5.0]
  def change
      remove_column :staffers, :staff_text, :string
      remove_column :staffers, :sfdc_cont_active, :string
      remove_column :staffers, :group_name, :string
      remove_column :staffers, :ult_group_name, :string
      remove_column :staffers, :influence, :string
      remove_column :staffers, :cell_phone, :string
      remove_column :staffers, :last_activity_date, :string
      remove_column :staffers, :franchise, :string
      remove_column :staffers, :coordinates, :string
      remove_column :staffers, :franch_cat, :string
      remove_column :staffers, :cont_merge_stat, :string
      remove_column :staffers, :cont_merge_stat_dt, :string
      remove_column :staffers, :created_date, :string
      remove_column :staffers, :updated_date, :string
      remove_column :staffers, :template, :string
      remove_column :staffers, :staff_link, :string
  end
end
