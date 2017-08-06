class Indexer < ApplicationRecord
  include Filterable
  include CSVTool

  # == Multi-Select Search ==
  scope :indexer_status, -> (indexer_status) { where indexer_status: indexer_status }
  scope :redirect_status, -> (redirect_status) { where redirect_status: redirect_status }
  scope :who_status, -> (who_status) { where who_status: who_status }
  scope :template, -> (template) { where template: template }
  scope :stf_status, -> (stf_status) { where stf_status: stf_status }
  scope :loc_status, -> (loc_status) { where loc_status: loc_status }
  scope :rt_sts, -> (rt_sts) { where rt_sts: rt_sts }
  scope :contact_status, -> (contact_status) { where contact_status: contact_status }
  scope :geo_status, -> (geo_status) { where geo_status: geo_status }
  scope :score100, -> (score100) { where score100: score100 }
  scope :score75, -> (score75) { where score75: score75 }
  scope :score50, -> (score50) { where score50: score50 }
  scope :score25, -> (score25) { where score25: score25 }
  scope :bug, -> (bug) { where bug: bug }
  scope :cop_type, -> (cop_type) { where cop_type: cop_type }
  scope :state, -> (state) { where state: state }

  # == Key Word Search ==
  scope :raw_url, -> (raw_url) { where("raw_url like ?", "%#{raw_url}%") }
  scope :acct_name, -> (acct_name) { where("acct_name like ?", "%#{acct_name}%") }
  scope :acct_pin, -> (acct_pin) { where("acct_pin like ?", "%#{acct_pin}%") }

  scope :street, -> (street) { where("street like ?", "%#{street}%") }
  scope :city, -> (city) { where("city like ?", "%#{city}%") }
  scope :zip, -> (zip) { where("zip like ?", "%#{zip}%") }
  scope :full_addr, -> (full_addr) { where("full_addr like ?", "%#{full_addr}%") }
  scope :clean_url, -> (clean_url) { where("clean_url like ?", "%#{clean_url}%") }
  scope :phone, -> (phone) { where("phone like ?", "%#{phone}%") }

end
