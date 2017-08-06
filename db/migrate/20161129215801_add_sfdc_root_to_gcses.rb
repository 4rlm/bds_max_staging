class AddSfdcRootToGcses < ActiveRecord::Migration[5.0]
  def change
    add_column :gcses, :sfdc_root, :string
  end
end
