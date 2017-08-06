class AddColumnsToCores11 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :temporary_id, :string
      add_column :cores, :url_status, :string
      add_column :cores, :hierarchy, :string
  end
end
