class RemoveColumnsFromLocations5 < ActiveRecord::Migration[5.0]
  def change
    #   remove_column :locations, :rev_full_address, :string
      remove_column :locations, :rev_street, :string
      remove_column :locations, :rev_city, :string
      remove_column :locations, :rev_state, :string
      remove_column :locations, :rev_state_code, :string
      remove_column :locations, :rev_postal_code, :string
  end
end
