class AddColumnsToCores26 < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :redirect_sts, :string
  end
end
