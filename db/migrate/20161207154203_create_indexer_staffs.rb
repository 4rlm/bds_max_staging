class CreateIndexerStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :indexer_staffs do |t|
      t.string :indexer_status
      t.string :sfdc_acct
      t.string :sfdc_group_name
      t.string :sfdc_ult_acct
      t.string :root
      t.string :domain
      t.string :ip
      t.string :text
      t.string :href
      t.string :staff_link
      t.string :msg
      t.string :sfdc_street
      t.string :sfdc_city
      t.string :sfdc_state
      t.string :sfdc_type
      t.string :sfdc_tier
      t.string :sfdc_sales_person
      t.string :sfdc_id
      t.datetime :indexer_timestamp

      t.timestamps
    end
  end
end
