class AddColumnsStaffers < ActiveRecord::Migration[5.0]
  def change
      add_column :staffers, :acct_name, :string
      add_column :staffers, :group_name, :string
      add_column :staffers, :ult_group_name, :string
      add_column :staffers, :street, :string
      add_column :staffers, :city, :string
      add_column :staffers, :state, :string
      add_column :staffers, :zip, :string
      add_column :staffers, :fname, :string
      add_column :staffers, :lname, :string
      add_column :staffers, :fullname, :string
      add_column :staffers, :job, :string
      add_column :staffers, :job_raw, :string
      add_column :staffers, :phone, :string
      add_column :staffers, :email, :string
      add_column :staffers, :influence, :string
  end
end
