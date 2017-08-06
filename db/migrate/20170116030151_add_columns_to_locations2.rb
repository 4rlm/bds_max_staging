class AddColumnsToLocations2 < ActiveRecord::Migration[5.0]
  def change
      add_column :locations, :acct_name, :string
      add_column :locations, :group_name, :string
      add_column :locations, :ult_group_name, :string
      add_column :locations, :source, :string
  end
end
