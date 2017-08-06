class AddColumnsToCores13 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :geo_status, :string
  end
end
