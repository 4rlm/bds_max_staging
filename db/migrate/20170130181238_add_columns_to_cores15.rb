class AddColumnsToCores15 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :crm_phone, :string
  end
end
