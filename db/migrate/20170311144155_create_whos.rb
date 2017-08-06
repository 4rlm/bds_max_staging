class CreateWhos < ActiveRecord::Migration[5.0]
  def change
    create_table :whos do |t|
      t.string :domain
      t.string :domain_id
      t.string :ip
      t.string :server1
      t.string :server2
      t.string :registrar_url
      t.string :registrar_id
      t.string :registrant_id
      t.string :registrant_type
      t.string :registrant_name
      t.string :registrant_organization
      t.string :registrant_address
      t.string :registrant_city
      t.string :registrant_zip
      t.string :registrant_state
      t.string :registrant_country
      t.string :registrant_country_code
      t.string :registrant_phone
      t.string :registrant_fax
      t.string :registrant_email
      t.string :registrant_url
      t.string :registrant_created_on
      t.string :registrant_updated_on
      t.string :admin_id
      t.string :admin_type
      t.string :admin_name
      t.string :admin_organization
      t.string :admin_address
      t.string :admin_city
      t.string :admin_zip
      t.string :admin_state
      t.string :admin_country
      t.string :admin_country_code
      t.string :admin_phone
      t.string :admin_fax
      t.string :admin_email
      t.string :admin_url
      t.string :admin_created_on
      t.string :admin_updated_on
      t.string :tech_id
      t.string :tech_type
      t.string :tech_name
      t.string :tech_organization
      t.string :tech_address
      t.string :tech_city
      t.string :tech_zip
      t.string :tech_state
      t.string :tech_country
      t.string :tech_country_code
      t.string :tech_phone
      t.string :tech_fax
      t.string :tech_email
      t.string :tech_url
      t.string :tech_created_on
      t.string :tech_updated_on

      t.timestamps
    end
  end
end
