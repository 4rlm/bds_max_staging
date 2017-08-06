class SearchController < ApplicationController
  # Hide all CRUD actions 2017.03.10
  # So all CRUD actions are only accessible to admin only for now.
  before_action :admin_only, only: [:index]

  def index
    
    # == Google API Starts ==Test ! Starts ===
    if params[:q]
      page = params[:page]
      @results = GoogleCustomSearchApi.search(params[:q], page: page)
    end

    # @results = GoogleCustomSearchApi.search(@test_encoded_search)
    # @results = GoogleCustomSearchApi.search("poker", page: 2)
    # @results.pages == 10
    # @results.current_page == 2
    # @results.next_page == 3
    # @results.previous_page == 1
    # @results = GoogleCustomSearchApi.search_and_return_all_results('grossinger toyota')
    # @results = search_and_return_all_results('grossinger toyota')
    # @results.first.items.size # == 10
    # == Google API Starts ==Test ! Ends ===

    # == Google API Starts ==Perfect! Starts ===
    # if params[:q]
    #   page = params[:page] || 1
    #   @results = GoogleCustomSearchApi.search(params[:q], page: page)
    # end
    # == Google API Starts ==Perfect! Ends ===

  end

  def search_result_core
    set_selected_status_core({bds_status: params[:bds_status], sfdc_id: params[:sfdc_id], sfdc_tier: params[:sfdc_tier], sfdc_sales_person: params[:sfdc_sales_person], sfdc_type: params[:sfdc_type], sfdc_ult_grp: params[:sfdc_ult_grp], sfdc_group: params[:sfdc_group], sfdc_acct: params[:sfdc_acct], sfdc_street: params[:sfdc_street], sfdc_city: params[:sfdc_city], sfdc_state: params[:sfdc_state], sfdc_ph: params[:sfdc_ph], staff_pf_sts: params[:staff_pf_sts], loc_pf_sts: params[:loc_pf_sts], staffer_sts: params[:staffer_sts], sfdc_franchise: params[:sfdc_franchise], sfdc_franch_cat: params[:sfdc_franch_cat], sfdc_franch_cons: params[:sfdc_franch_cons], template: params[:template], full_address: params[:full_address], coordinates: params[:coordinates], geo_sts: params[:geo_sts], cop_franch: params[:cop_franch], conf_cat: params[:conf_cat], sfdc_zip: params[:sfdc_zip], sfdc_clean_url: params[:sfdc_clean_url], crm_acct_pin: params[:crm_acct_pin], crm_phones: params[:crm_phones], who_sts: params[:who_sts], match_score: params[:match_score], acct_match_sts: params[:acct_match_sts], ph_match_sts: params[:ph_match_sts], pin_match_sts: params[:pin_match_sts], url_match_sts: params[:url_match_sts], acct_merge_sts: params[:acct_merge_sts], redirect_sts: params[:redirect_sts], view_mode: params[:view_mode]})
    redirect_to cores_path
  end

  def search_result_staffer
    set_selected_status_staffer({staffer_status: params[:staffer_status], cont_status: params[:cont_status], cont_source: params[:cont_source], sfdc_id: params[:sfdc_id], sfdc_sales_person: params[:sfdc_sales_person], sfdc_type: params[:sfdc_type], sfdc_cont_id: params[:sfdc_cont_id], staffer_date: params[:staffer_date], sfdc_tier: params[:sfdc_tier], domain: params[:domain], acct_name: params[:acct_name], street: params[:street], city: params[:city], state: params[:state], zip: params[:zip], fname: params[:fname], fullname: params[:fullname], job: params[:job], job_raw: params[:job_raw], email: params[:email], full_address: params[:full_address], acct_pin: params[:acct_pin], cont_pin: params[:cont_pin], view_mode: params[:view_mode]})
    redirect_to staffers_path
  end

  def search_result_location
    set_selected_status_location({ latitude: params[:latitude], longitude: params[:longitude], created_at: params[:created_at], updated_at: params[:updated_at], city: params[:city], state_code: params[:state_code], postal_code: params[:postal_code], coordinates: params[:coordinates], acct_name: params[:acct_name], group_name: params[:group_name], ult_group_name: params[:ult_group_name], source: params[:source], sfdc_id: params[:sfdc_id], tier: params[:tier], sales_person: params[:sales_person], acct_type: params[:acct_type], location_status: params[:location_status], url: params[:url], street: params[:street], address: params[:address], view_mode: params[:view_mode], temporary_id: params[:temporary_id], geo_acct_name: params[:geo_acct_name], geo_full_addr: params[:geo_full_addr], crm_source: params[:crm_source], geo_franch_cons: params[:geo_franch_cons], geo_franch_cat: params[:geo_franch_cat], crm_franch_cons: params[:crm_franch_cons], crm_franch_cat: params[:crm_franch_cat], geo_root: params[:geo_root], crm_root: params[:crm_root], crm_url: params[:crm_url], crm_phone: params[:crm_phone], crm_url_redirect: params[:crm_url_redirect], geo_url_redirect: params[:geo_url_redirect], sts_geo_crm: params[:sts_geo_crm], sts_url: params[:sts_url], sts_root: params[:sts_root], sts_acct: params[:sts_acct], sts_addr: params[:sts_addr], sts_ph: params[:sts_ph], sts_duplicate: params[:sts_duplicate]})
    redirect_to locations_path
  end


  def search_result_indexer
    set_selected_status_indexer({raw_url: params[:raw_url], redirect_status: params[:redirect_status], clean_url: params[:clean_url], indexer_status: params[:indexer_status], template: params[:template], loc_status: params[:loc_status], stf_status: params[:stf_status], contact_status: params[:contact_status], acct_name: params[:acct_name], rt_sts: params[:rt_sts], cont_sts: params[:cont_sts], state: params[:state], street: params[:street], city: params[:city], zip: params[:zip], full_addr: params[:full_addr], phone: params[:phone], acct_pin: params[:acct_pin], who_status: params[:who_status], geo_status: params[:geo_status], score100: params[:score100], score75: params[:score75], score50: params[:score50], score25: params[:score25], bug: params[:bug], cop_type: params[:cop_type]})
    redirect_to indexers_path
  end


  def search_result_who
    set_selected_status_who({who_status: params[:who_status], url_status: params[:url_status], domain: params[:domain], ip: params[:ip], server1: params[:server1], server2: params[:server2], registrant_name: params[:registrant_name], registrant_organization: params[:registrant_organization], registrant_address: params[:registrant_address], registrant_city: params[:registrant_city], registrant_state: params[:registrant_state], registrant_zip: params[:registrant_zip], registrant_phone: params[:registrant_phone], registrant_url: params[:registrant_url], who_addr_pin: params[:who_addr_pin]})
    redirect_to whos_path
  end


  # == Google API Testing Search Methods - Starts ===

  # == Testing MY Google API - Search Method V1 - Perfect! ==
  # def test_encoded_search
  #     q = "automobile dealerships in hawaii"
  # end
  # == Testing MY Google API - Search Method V1 - Ends  ==

  # == Testing MY Google API - Search Method V2 ==
  def test_encoded_search
    # q = "automobile dealerships in hawaii"

    #-----------------
    acct = "Larry H. Miller Hyundai Peoria"
    street = "8425 W Bell Rd"
    city = "Peoria"
    state = "AZ"

    #-----------------
    # if acct != nil
    acct_gs = acct.gsub(/[ ]/, '%20')
    acct_q = "#{acct_gs}+"
    # end
    # if street != nil
    street_gs = street.gsub(/[ ]/, '%20')
    street_q = "#{street_gs}+"
    # end
    # if city != nil
    city_gs = city.gsub(/[ ]/, '%20')
    city_q = "#{city_gs}+"
    # end
    # if state != nil
    state_st = state
    # end

    #-----------------
    # q = "#{acct}#{city},#{state}"


    # num = "&num=100"
    # client = "&client=google-csbe"
    # key = "&cx=016494735141549134606:xzyw78w1vn0"
    # tag1 = "&as_oq=auto+automobile+car+cars+vehicle+vehicles"
    # tag2 = "&as_oq=dealer+dealership+group"

    # q_combinded = "q=#{acct_q}#{street_q}#{city_q}#{state_st}"
    # acct_req = "&as_epq=#{acct_gs}"
    # acct_opt = "&oq=#{acct_gs}"

    # q = "#{acct_q}#{street_q}#{city_q}#{state_st}"
    # q = "#{acct}#{street}#{city}#{state}#{num}"
    # q = "automobile dealerships in hawaii"

  end
  # == Testing MY Google API - Search Method V2 - Ends  ==

  # == Google API Testing Search Methods - Ends ===
end
