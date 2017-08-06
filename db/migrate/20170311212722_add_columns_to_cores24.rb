class AddColumnsToCores24 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :who_status, :string
  end
end
