class Location < ApplicationRecord
  include Filterable
  include CSVTool

  # GEOCODE - GOOGLE - FORWARD #
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  # GEOCODE - GOOGLE - REVERSE #
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address
  
  # reverse_geocoded_by :latitude, :longitude do |obj,results|
  #   if geo = results.first
  #     obj.city    = geo.city
  #     obj.zipcode = geo.postal_code
  #     obj.country = geo.country_code
  #   end
  # end
  # after_validation :reverse_geocode

  # == Multi-Select Search ==
  scope :state_code, -> (state_code) { where state_code: state_code }
  scope :source, -> (source) { where source: source }
  scope :tier, -> (tier) { where tier: tier }
  scope :sales_person, -> (sales_person) { where sales_person: sales_person }
  scope :acct_type, -> (acct_type) { where acct_type: acct_type }
  scope :location_status, -> (location_status) { where location_status: location_status }
  scope :crm_source, -> (crm_source) { where crm_source: crm_source }
  scope :geo_franch_cons, -> (geo_franch_cons) { where geo_franch_cons: geo_franch_cons }
  scope :geo_franch_cat, -> (geo_franch_cat) { where geo_franch_cat: geo_franch_cat }
  scope :crm_franch_cons, -> (crm_franch_cons) { where crm_franch_cons: crm_franch_cons }
  scope :crm_franch_cat, -> (crm_franch_cat) { where crm_franch_cat: crm_franch_cat }

  scope :crm_url_redirect, -> (crm_url_redirect) { where crm_url_redirect: crm_url_redirect }
  scope :geo_url_redirect, -> (geo_url_redirect) { where geo_url_redirect: geo_url_redirect }
  scope :sts_duplicate, -> (sts_duplicate) { where sts_duplicate: sts_duplicate }

  scope :sts_geo_crm, -> (sts_geo_crm) { where sts_geo_crm: sts_geo_crm }
  scope :sts_url, -> (sts_url) { where sts_url: sts_url }
  scope :sts_root, -> (sts_root) { where sts_root: sts_root }
  scope :sts_acct, -> (sts_acct) { where sts_acct: sts_acct }
  scope :sts_addr, -> (sts_addr) { where sts_addr: sts_addr }
  scope :sts_ph, -> (sts_ph) { where sts_ph: sts_ph }

  # == Key Word Search ==
  scope :latitude, -> (latitude) { where("latitude like ?", "%#{latitude}%") }
  scope :longitude, -> (longitude) { where("longitude like ?", "%#{longitude}%") }
  scope :created_at, -> (created_at) { where("created_at like ?", "%#{created_at}%") }
  scope :updated_at, -> (updated_at) { where("updated_at like ?", "%#{updated_at}%") }
  scope :city, -> (city) { where("city like ?", "%#{city}%") }
  scope :postal_code, -> (postal_code) { where("postal_code like ?", "%#{postal_code}%") }
  scope :coordinates, -> (coordinates) { where("coordinates like ?", "%#{coordinates}%") }
  scope :acct_name, -> (acct_name) { where("acct_name like ?", "%#{acct_name}%") }
  scope :group_name, -> (group_name) { where("group_name like ?", "%#{group_name}%") }
  scope :ult_group_name, -> (ult_group_name) { where("ult_group_name like ?", "%#{ult_group_name}%") }
  scope :sfdc_id, -> (sfdc_id) { where("sfdc_id like ?", "%#{sfdc_id}%") }
  scope :url, -> (url) { where("url like ?", "%#{url}%") }
  scope :street, -> (street) { where("street like ?", "%#{street}%") }
  scope :address, -> (address) { where("address like ?", "%#{address}%") }
  scope :temporary_id, -> (temporary_id) { where("temporary_id like ?", "%#{temporary_id}%") }
  scope :geo_acct_name, -> (geo_acct_name) { where("geo_acct_name like ?", "%#{geo_acct_name}%") }
  scope :geo_full_addr, -> (geo_full_addr) { where("geo_full_addr like ?", "%#{geo_full_addr}%") }
  scope :geo_root, -> (geo_root) { where("geo_root like ?", "%#{geo_root}%") }
  scope :crm_root, -> (crm_root) { where("crm_root like ?", "%#{crm_root}%") }
  scope :crm_url, -> (crm_url) { where("crm_url like ?", "%#{crm_url}%") }

end
