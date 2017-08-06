class AddJsonTypeColToDashboards < ActiveRecord::Migration[5.0]
  def change
      add_column :dashboards, :obj_list, :json, default: {}
  end
end
