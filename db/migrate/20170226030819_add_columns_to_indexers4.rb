class AddColumnsToIndexers4 < ActiveRecord::Migration[5.0]
  def change
      add_column :indexers, :acct_name, :string
      add_column :indexers, :rt_sts, :string
      add_column :indexers, :cont_sts, :string
      add_column :indexers, :full_addr, :string
      add_column :indexers, :street, :string
      add_column :indexers, :city, :string
      add_column :indexers, :state, :string
      add_column :indexers, :zip, :string
      add_column :indexers, :phone, :string 
  end
end
