class AddColumnsToInHostPos2 < ActiveRecord::Migration[5.0]
  def change
      add_column :in_host_pos, :cat_count, :string
  end
end
