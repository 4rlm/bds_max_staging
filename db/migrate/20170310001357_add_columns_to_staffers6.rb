class AddColumnsToStaffers6 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :acct_pin, :string
      add_column :staffers, :cont_pin, :string
  end
end
