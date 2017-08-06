class AddStaffCountToIndexers < ActiveRecord::Migration[5.0]
  def change
    add_column :indexers, :staff_count, :integer, default: 0
  end
end
