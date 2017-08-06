class AddNewColsToCores < ActiveRecord::Migration[5.0]
    def change
        add_column :cores, :domain_status, :string
        add_column :cores, :staffer_status, :string
        add_column :cores, :acct_indicator, :string
        add_column :cores, :sfdc_group_indicator, :string
        add_column :cores, :sfdc_ult_grp_indicator, :string
        add_column :cores, :template, :string
        add_column :cores, :site_acct, :string
        add_column :cores, :site_street, :string
        add_column :cores, :site_city, :string
        add_column :cores, :site_state, :string
        add_column :cores, :site_zip, :integer
        add_column :cores, :site_ph, :string
        add_column :cores, :street_indicator, :string
        add_column :cores, :city_indicator, :string
        add_column :cores, :state_indicator, :string
        add_column :cores, :zip_indicator, :string
        add_column :cores, :ph_indicator, :string
        add_column :cores, :verified_ult_rt_indicator, :string
        add_column :cores, :verified_grp_rt_indicator, :string
        add_column :cores, :grp_rt_indicator, :string
        add_column :cores, :ult_grp_rt_indicator, :string
        add_column :cores, :sfdc_franch_indicator, :string
        add_column :cores, :site_franch_indicator, :string
        add_column :cores, :franch_indicator, :string
    end
end
