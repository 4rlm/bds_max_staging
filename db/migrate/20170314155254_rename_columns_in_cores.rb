class RenameColumnsInCores < ActiveRecord::Migration[5.0]
  def change
      rename_column :cores, :staff_pf_status, :staff_pf_sts
      rename_column :cores, :loc_pf_status, :loc_pf_sts
      rename_column :cores, :staffer_status, :staffer_sts
      rename_column :cores, :geo_status, :geo_sts
  end
end
