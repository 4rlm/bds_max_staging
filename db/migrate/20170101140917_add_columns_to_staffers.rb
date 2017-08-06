class AddColumnsToStaffers < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :staff_link, :string
      add_column :staffers, :staff_text, :string
  end
end
