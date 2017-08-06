class AddColumnsToInHostPos1 < ActiveRecord::Migration[5.0]
  def change
      add_column :in_host_pos, :brand_count, :string
  end
end
