class RemoveColumnsFromWhos2 < ActiveRecord::Migration[5.0]
  def change
      remove_column :whos, :admin_pin, :string
      remove_column :whos, :tech_pin, :string
      remove_column :whos, :registrant_pin, :string
      remove_column :whos, :tech_url, :string
      remove_column :whos, :tech_email, :string
      remove_column :whos, :tech_fax, :string
      remove_column :whos, :tech_phone, :string
      remove_column :whos, :tech_state, :string
      remove_column :whos, :tech_zip, :string
      remove_column :whos, :tech_city, :string
      remove_column :whos, :tech_address, :string
      remove_column :whos, :tech_organization, :string
      remove_column :whos, :tech_name, :string
      remove_column :whos, :tech_type, :string
      remove_column :whos, :tech_id, :string
      remove_column :whos, :admin_url, :string
      remove_column :whos, :admin_email, :string
      remove_column :whos, :admin_fax, :string
      remove_column :whos, :admin_phone, :string
      remove_column :whos, :admin_state, :string
      remove_column :whos, :admin_zip, :string
      remove_column :whos, :admin_city, :string
      remove_column :whos, :admin_address, :string
      remove_column :whos, :admin_organization, :string
      remove_column :whos, :admin_name, :string
      remove_column :whos, :admin_type, :string
      remove_column :whos, :admin_id, :string
      remove_column :whos, :registrant_type, :string
      remove_column :whos, :registrant_id, :string
  end
end
