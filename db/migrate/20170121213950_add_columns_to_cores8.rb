class AddColumnsToCores8 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :franch_cons_ind, :string
      add_column :cores, :franch_cat_ind, :string
  end
end
