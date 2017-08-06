class CreateGcses < ActiveRecord::Migration[5.0]
  def change
    create_table :gcses do |t|
      t.timestamp :gcse_timestamp
      t.integer :gcse_query_num
      t.integer :gcse_result_num
      t.string :sfdc_id
      t.string :sfdc_ult_acct
      t.string :sfdc_acct
      t.string :sfdc_type
      t.string :sfdc_street
      t.string :sfdc_city
      t.string :sfdc_state
      t.string :sfdc_url_o
      t.string :domain_status
      t.string :domain
      t.string :root
      t.string :suffix
      t.string :in_host_pos
      t.string :in_host_neg
      t.string :in_host_del
      t.string :in_suffix_del
      t.string :exclude_root
      t.string :text
      t.string :in_text_pos
      t.string :in_text_neg
      t.string :in_text_del
      t.string :url_encoded

      t.timestamps
    end
  end
end
