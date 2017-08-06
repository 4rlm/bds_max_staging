class AddMatchedRootToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :matched_root, :string
  end
end
