class RemoveTempIdFromCores < ActiveRecord::Migration[5.0]
  def change
      remove_column :cores, :temp_id, :string
  end
end
