class AddColumnsToCores4 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :site_ult_grp, :string
      add_column :cores, :site_group, :string
  end
end
