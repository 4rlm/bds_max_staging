class AddUrlComparisonToCores < ActiveRecord::Migration[5.0]
  def change
    add_column :cores, :url_comparison, :string
  end
end
