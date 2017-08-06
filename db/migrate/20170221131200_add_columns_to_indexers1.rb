class AddColumnsToIndexers1 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :loc_status, :string
      add_column :indexers, :stf_status, :string      
  end
end
