class AddColsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :work_phone, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :role, :integer
  end
end
