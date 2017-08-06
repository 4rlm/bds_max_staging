class AddColumnsToCores19 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :img_url, :string
  end
end
