class RemoveColumnsFromStaffers < ActiveRecord::Migration[5.0]
  def change
      remove_column :staffers, :sfdc_acct, :string
      remove_column :staffers, :site_acct, :string
      remove_column :staffers, :sfdc_group, :string
      remove_column :staffers, :sfdc_ult_grp, :string
      remove_column :staffers, :site_street, :string
      remove_column :staffers, :site_city, :string
      remove_column :staffers, :site_state, :string
      remove_column :staffers, :site_zip, :integer
      remove_column :staffers, :site_ph, :string
      remove_column :staffers, :site_cont_fname, :string
      remove_column :staffers, :sfdc_cont_lname, :string
      remove_column :staffers, :site_cont_lname, :string
      remove_column :staffers, :sfdc_cont_fname, :string
      remove_column :staffers, :site_cont_fullname, :string
      remove_column :staffers, :sfdc_cont_job, :string
      remove_column :staffers, :site_cont_job, :string
      remove_column :staffers, :site_cont_job_raw, :string
      remove_column :staffers, :sfdc_cont_phone, :string
      remove_column :staffers, :site_cont_phone, :string
      remove_column :staffers, :sfdc_cont_email, :string
      remove_column :staffers, :site_cont_email, :string
      remove_column :staffers, :sfdc_cont_influence, :string
      remove_column :staffers, :site_cont_influence, :string
  end
end
