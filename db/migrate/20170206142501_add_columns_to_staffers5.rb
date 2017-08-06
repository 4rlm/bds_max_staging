class AddColumnsToStaffers5 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :cont_merge_stat, :string
      add_column :staffers, :cont_merge_stat_dt, :string
  end
end
