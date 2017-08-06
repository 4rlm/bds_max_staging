class AddColumnToCores < ActiveRecord::Migration[5.0]
  def change
      add_column :cores, :franchise, :string;
  end
end
