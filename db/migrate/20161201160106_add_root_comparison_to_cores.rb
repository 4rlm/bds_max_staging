class AddRootComparisonToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :root_comparison, :string
  end
end
