class CreateStaffers < ActiveRecord::Migration[5.0]
  def change
    create_table :staffers do |t|
      t.string :staffer_status
      t.string :cont_status
      t.string :cont_source
      t.string :sfdc_id
      t.string :sfdc_sales_person
      t.string :sfdc_type
      t.string :sfdc_acct
      t.string :site_acct
      t.string :sfdc_group
      t.string :sfdc_ult_grp
      t.string :site_street
      t.string :site_city
      t.string :site_state
      t.integer :site_zip
      t.string :site_ph
      t.string :sfdc_cont_fname
      t.string :sfdc_cont_lname
      t.string :sfdc_cont_job
      t.string :sfdc_cont_phone
      t.string :sfdc_cont_email
      t.string :sfdc_cont_inactive
      t.string :sfdc_cont_id
      t.integer :sfdc_cont_influence
      t.string :site_cont_fname
      t.string :site_cont_lname
      t.string :site_cont_fullname
      t.string :site_cont_job
      t.string :site_cont_job_raw
      t.string :site_cont_phone
      t.string :site_cont_email
      t.integer :site_cont_influence
      t.string :template
      t.datetime :staffer_date

      t.timestamps
    end
  end
end
