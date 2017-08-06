class AddColumnsToCores7 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :sfdc_franch_cons, :string
      add_column :cores, :site_franch_cons, :string
      add_column :cores, :temp_id, :string
      add_column :cores, :coord_indicator, :string
  end
end
