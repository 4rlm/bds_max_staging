class AddColumnsToCores2 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :site_franchise, :string;
      add_column :cores, :sfdc_franchise, :string;
      add_column :cores, :site_ult_rt, :string;
      add_column :cores, :site_grp_rt, :string; 
  end
end
