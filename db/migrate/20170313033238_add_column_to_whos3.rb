class AddColumnToWhos3 < ActiveRecord::Migration[5.0]
  def change
      add_column :whos, :who_addr_pin, :string
  end
end
