class RemoveColumnsFromWhos1 < ActiveRecord::Migration[5.0]
  def change
      remove_column :whos, :tech_created_on, :string
      remove_column :whos, :tech_updated_on, :string
      remove_column :whos, :tech_country, :string
      remove_column :whos, :tech_country_code, :string
      remove_column :whos, :registrant_country, :string
      remove_column :whos, :registrant_country_code, :string
      remove_column :whos, :registrant_created_on, :string
      remove_column :whos, :registrant_updated_on, :string
      remove_column :whos, :admin_country, :string
      remove_column :whos, :admin_country_code, :string
      remove_column :whos, :admin_created_on, :string
      remove_column :whos, :admin_updated_on, :string
  end
end
