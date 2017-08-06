class AddColumnsToInHostPos < ActiveRecord::Migration[5.0]
  def change
      add_column :in_host_pos, :consolidated_term, :string
      add_column :in_host_pos, :category, :string
  end
end
