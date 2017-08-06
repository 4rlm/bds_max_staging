class AddColumnsToCores10 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_template, :string
  end
end
