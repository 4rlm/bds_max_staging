class AddSfdcRootToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :sfdc_root, :string
  end
end
