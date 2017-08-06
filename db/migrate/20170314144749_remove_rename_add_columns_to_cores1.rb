class RemoveRenameAddColumnsToCores1 < ActiveRecord::Migration[5.0]
  def change
      rename_column :cores, :staff_indexer_status, :staff_pf_status
      rename_column :cores, :location_indexer_status, :loc_pf_status
      rename_column :cores, :sfdc_template, :template
      rename_column :cores, :who_status, :who_sts
      rename_column :cores, :acct_match_score, :match_score
      rename_column :cores, :org_match_status, :acct_match_sts
      rename_column :cores, :ph_match_status, :ph_match_sts
      rename_column :cores, :pin_match_status, :pin_match_sts
      rename_column :cores, :url_match_status, :url_match_sts

      remove_column :cores, :geo_full_address, :string
      remove_column :cores, :core_date, :datetime
      remove_column :cores, :acct_source, :string
      remove_column :cores, :crm_phone, :string
      remove_column :cores, :geo_acct_name, :string

      add_column :cores, :alt_acct_pin, :string
      add_column :cores, :alt_acct, :string
      add_column :cores, :alt_street, :string
      add_column :cores, :alt_city, :string
      add_column :cores, :alt_state, :string
      add_column :cores, :alt_zip, :string
      add_column :cores, :alt_ph, :string
      add_column :cores, :alt_url, :string
      add_column :cores, :alt_source, :string
      add_column :cores, :alt_address, :string
      add_column :cores, :alt_template, :string
  end
end
