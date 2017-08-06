class AddColumnsToCores9 < ActiveRecord::Migration[5.0]
  def change
        add_column :cores, :template_ind, :string
  end
end
