class AddRootCounterToGcses < ActiveRecord::Migration[5.0]
  def change
    add_column :gcses, :root_counter, :integer
  end
end
