class AddColumnsToStaffers3 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :coordinates, :string
      add_column :staffers, :full_address, :string
      add_column :staffers, :franch_cat, :string
  end
end
