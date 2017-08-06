class AddColumnsToStaffers2 < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :cell_phone, :string
      add_column :staffers, :last_activity_date, :datetime
      add_column :staffers, :created_date, :datetime
      add_column :staffers, :updated_date, :datetime
      add_column :staffers, :franchise, :string
  end
end
