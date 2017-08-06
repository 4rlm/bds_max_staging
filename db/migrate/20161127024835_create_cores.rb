class CreateCores < ActiveRecord::Migration[5.0]
  def change
    create_table :cores do |t|
      t.string :bds_status
      t.string :sfdc_id
      t.integer :sfdc_tier
      t.string :sfdc_sales_person
      t.string :sfdc_type
      t.string :sfdc_ult_grp
      t.integer :sfdc_ult_rt
      t.string :sfdc_group
      t.integer :sfdc_grp_rt
      t.string :sfdc_acct
      t.string :sfdc_street
      t.string :sfdc_city
      t.string :sfdc_state
      t.integer :sfdc_zip
      t.string :sfdc_ph
      t.string :sfdc_url

      t.timestamps
    end
  end
end
