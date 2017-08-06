class AddColumnsToInTextPos < ActiveRecord::Migration[5.0]
  def change
      add_column :in_text_pos, :consolidated_term, :string
      add_column :in_text_pos, :category, :string
  end
end
