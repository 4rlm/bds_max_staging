class RemoveCrmStaffCountFromIndexers < ActiveRecord::Migration[5.0]
  def change
      remove_column :indexers, :crm_staff_count, :integer
  end
end
