class Staffer < ApplicationRecord
  include Filterable
  include CSVTool

  # == Multi-Select Search ==
  scope :staffer_status, -> (staffer_status) { where staffer_status: staffer_status }
  scope :sfdc_sales_person, -> (sfdc_sales_person) { where sfdc_sales_person: sfdc_sales_person }
  scope :sfdc_type, -> (sfdc_type) { where sfdc_type: sfdc_type }
  scope :sfdc_tier, -> (sfdc_tier) { where sfdc_tier: sfdc_tier }
  scope :cont_status, -> (cont_status) { where cont_status: cont_status }
  scope :cont_source, -> (cont_source) { where cont_source: cont_source }
  scope :job, -> (job) { where job: job }
  scope :state, -> (state) { where state: state }

  # == Key Word Search ==
  scope :sfdc_id, -> (sfdc_id) { where("sfdc_id like ?", "%#{sfdc_id}%") }
  scope :acct_name, -> (acct_name) { where("acct_name like ?", "%#{acct_name}%") }
  scope :street, -> (street) { where("street like ?", "%#{street}%") }
  scope :city, -> (city) { where("city like ?", "%#{city}%") }
  scope :zip, -> (zip) { where("zip like ?", "%#{zip}%") }
  scope :sfdc_cont_id, -> (sfdc_cont_id) { where("sfdc_cont_id like ?", "%#{sfdc_cont_id}%") }
  scope :fname, -> (fname) { where("fname like ?", "%#{fname}%") }
  scope :lname, -> (lname) { where("lname like ?", "%#{lname}%") }
  scope :fullname, -> (fullname) { where("fullname like ?", "%#{fullname}%") }
  scope :job_raw, -> (job_raw) { where("job_raw like ?", "%#{job_raw}%") }
  scope :phone, -> (phone) { where("phone like ?", "%#{phone}%") }
  scope :email, -> (email) { where("email like ?", "%#{email}%") }
  scope :staffer_date, -> (staffer_date) { where("staffer_date like ?", "%#{staffer_date}%") }
  scope :staff_link, -> (staff_link) { where("staff_link like ?", "%#{staff_link}%") }
  scope :domain, -> (domain) { where("domain like ?", "%#{domain}%") }
  scope :acct_pin, -> (acct_pin) { where("acct_pin like ?", "%#{acct_pin}%") }
  scope :cont_pin, -> (cont_pin) { where("cont_pin like ?", "%#{cont_pin}%") }

end
