class AddColumnsToWhos2 < ActiveRecord::Migration[5.0]
  def change
      add_column :whos, :registrant_pin, :string
      add_column :whos, :tech_pin, :string
      add_column :whos, :admin_pin, :string
  end
end
