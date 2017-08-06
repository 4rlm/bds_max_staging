class Core < ApplicationRecord
  include Filterable
  include CSVTool

  def self.sql_string(array)
    sql_str = ""
    array.each do |el|
      sql_str << "site_franchise LIKE '%#{el}%' OR "
    end
    sql_str[0..-5]
  end

  # == Multi-Select Search ==
  scope :bds_status, -> (bds_status) { where bds_status: bds_status }
  scope :sfdc_tier, -> (sfdc_tier) { where sfdc_tier: sfdc_tier}
  scope :sfdc_sales_person, -> (sfdc_sales_person) { where sfdc_sales_person: sfdc_sales_person}
  scope :sfdc_type, -> (sfdc_type) { where sfdc_type: sfdc_type}
  scope :sfdc_state, -> (sfdc_state) { where sfdc_state: sfdc_state}
  scope :staff_pf_sts, -> (staff_pf_sts) { where staff_pf_sts: staff_pf_sts}
  scope :loc_pf_sts, -> (loc_pf_sts) { where loc_pf_sts: loc_pf_sts}
  scope :staffer_sts, -> (staffer_sts) { where staffer_sts: staffer_sts}
  scope :sfdc_franchise, -> (sfdc_franchise) { where sfdc_franchise: sfdc_franchise}
  scope :sfdc_franch_cat, -> (sfdc_franch_cat) { where sfdc_franch_cat: sfdc_franch_cat}
  scope :sfdc_franch_cons, -> (sfdc_franch_cons) { where sfdc_franch_cons: sfdc_franch_cons}
  scope :template, -> (template) { where template: template}
  scope :geo_sts, -> (geo_sts) { where geo_sts: geo_sts}
  scope :conf_cat, -> (conf_cat) { where conf_cat: conf_cat}
  scope :cop_franch, -> (cop_franch) { where cop_franch: cop_franch}
  scope :who_sts, -> (who_sts) { where who_sts: who_sts}
  scope :match_score, -> (match_score) { where match_score: match_score}
  scope :acct_match_sts, -> (acct_match_sts) { where acct_match_sts: acct_match_sts}
  scope :ph_match_sts, -> (ph_match_sts) { where ph_match_sts: ph_match_sts}
  scope :pin_match_sts, -> (pin_match_sts) { where pin_match_sts: pin_match_sts}
  scope :url_match_sts, -> (url_match_sts) { where url_match_sts: url_match_sts}
  scope :acct_merge_sts, -> (acct_merge_sts) { where acct_merge_sts: acct_merge_sts}
  scope :redirect_sts, -> (redirect_sts) { where redirect_sts: redirect_sts}

  # == Key Word Search ==
  scope :sfdc_id, -> (sfdc_id) { where("sfdc_id like ?", "%#{sfdc_id}%") }
  scope :sfdc_ult_grp, -> (sfdc_ult_grp) { where("sfdc_ult_grp LIKE ?", "%#{sfdc_ult_grp}%") }
  scope :sfdc_group, -> (sfdc_group) { where("sfdc_group LIKE ?", "%#{sfdc_group}%") }
  scope :sfdc_acct, -> (sfdc_acct) { where("sfdc_acct LIKE ?", "%#{sfdc_acct}%") }
  scope :sfdc_street, -> (sfdc_street) { where("sfdc_street LIKE ?", "%#{sfdc_street}%") }
  scope :sfdc_city, -> (sfdc_city) { where("sfdc_city LIKE ?", "%#{sfdc_city}%") }
  scope :sfdc_ph, -> (sfdc_ph) { where("sfdc_ph LIKE ?", "%#{sfdc_ph}%") }
  scope :full_address, -> (full_address) { where("full_address LIKE ?", "%#{full_address}%") }
  scope :coordinates, -> (coordinates) { where("coordinates LIKE ?", "%#{coordinates}%") }
  scope :sfdc_zip, -> (sfdc_zip) { where("sfdc_zip LIKE ?", "%#{sfdc_zip}%") }
  scope :sfdc_clean_url, -> (sfdc_clean_url) { where("sfdc_clean_url LIKE ?", "%#{sfdc_clean_url}%") }
  scope :crm_acct_pin, -> (crm_acct_pin) { where("crm_acct_pin LIKE ?", "%#{crm_acct_pin}%") }
  scope :crm_phones, -> (crm_phones) { where("crm_phones LIKE ?", "%#{crm_phones}%") }

end
