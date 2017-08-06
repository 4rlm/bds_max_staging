class LocationsController < ApplicationController
  before_action :intermediate_and_up, only: [:index, :show, :search]
  before_action :advanced_and_up, only: [:edit, :update, :merge_data, :flag_data]
  before_action :admin_only, only: [:new, :create, :destroy, :import_page, :import_csv_data, :turbo_matcher_btn, :location_power_btn, :geo_places_starter_btn, :location_cleaner_btn, :geo_update_migrate_btn, :geo_starter_btn]

  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_location_service, only: [:geo_starter_btn, :location_cleaner_btn, :geo_update_migrate_btn, :geo_places_starter_btn, :location_power_btn, :turbo_matcher_btn]
  before_action :set_option_list, only: [:index, :search]
  
  # GET /locations
  # GET /locations.json
  def index
    # MULTI-SELECT #
    if choice_hash = get_selected_status_location
      clean_choice_hash = {}
      @view_mode = choice_hash[:view_mode]

      choice_hash.each do |key, value|
        clean_choice_hash[key] = value if !value.nil? && value != "" && key != :view_mode
      end
      @locations = Location.where(clean_choice_hash).all
    else # choice_hash is nil
      @locations = Location.all
    end

    ## SET ORDER OF DISPLAYED DATA ##
    @locations = @locations.order(updated_at: :desc)


    @locations_count = Location.count
    @selected_locations_count = @locations.count

    # CSV #
    locations_csv = @locations.order(:longitude)
    respond_to do |format|
      format.html
      format.csv { render text: locations_csv.to_csv }
    end

    # WILL_PAGINATE #
    @locations = @locations.filter(filtering_params(params)).paginate(:page => params[:page], :per_page => 20)


    ## GEOCODER SEARCH NEARBY - STARTS##
    # if params[:search].present?
    #     #   @locations = Location.near(params[:search], 50, :order => :distance)
    #     @locations = Location.near(params[:search], 50)
    # else
    #     @locations = Location.all
    # end
    ## GEOCODER SEARCH NEARBY - ENDS##

    # CHECKBOX #
    batch_status


    # This is a Test for iFrame
    # @url = Location.find(params[:id])

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    # This is a Test for iFrame
    # @url = Location.find(params[:id])
    @locations = @location.nearbys(1)
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    Location.import_csv(file_name, Location, "location_status")

    flash[:notice] = "CSV imported successfully."
    redirect_to locations_path
  end


  def search
  end

  # Testing iFrame
  # def open_url
  #   @url = params[:url]
  # end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def turbo_matcher_btn
    # @service.turbo_matcher
    # @service.delay.turbo_matcher
    redirect_to locations_path
  end


  def location_power_btn
    # @service.street_cleaner
    # @service.white_space_cleaner

    # @service.delay.web_acct_name_cleaner
    # @service.www_inserter
    # @service.url_redirect_checker
    # @service.delay.url_redirect_checker
    # @service.address_checker
    # @service.root_and_url_finalizer
    # @service.delay.root_and_url_finalizer
    # @service.delay.root_matcher

    # @service.delay.sts_updater

    # @service.delay.loc_core_dup_remover

    # @service.delay.coord_id_arr_btn
    # @service.delay.duplicate_sts_btn
    # @service.delay.quick_coordinates_collector
    # @service.delay.cop_franch_migrator

    # @service.delay.phone_updater

    # @service.unmatched_url

    # @service.sts_duplicate_nil
    # @service.delay.missing_address

    # @service.db_check

    # @service.duplicate_match_collector
    # @service.delay.duplicate_match_collector

    # @service.delay.sts_duplicate_tagger

    # @service.sts_duplicate_destroyer

    # @service.dup_finder
    # @service.delay.dup_finder

    # @service.delay.crm_source_web_matcher

    # @service.mix_match_addr_acct

    # @service.delay.non_matched_url_finder

    # @service.sample_dup_finder
    # @service.delay.sample_dup_finder

    # @service.delay.url_dup_finder

    # @service.hybrid_address_matcher

    redirect_to locations_path
  end


  def geo_places_starter_btn
    @service.geo_places_starter
    # @service.delay.geo_places_starter

    redirect_to locations_path
  end

  # def geo_starter_btn  ## From Button
  #     # @service.delay.create_sfdc_loc
  #     # @service.create_sfdc_loc
  #     cores = Core.all[0..10]
  #
  #     LocationService.new.start_geo(cores)
  #     # LocationService.new.delay.start_geo(cores)
  #
  #     flash[:notice] = 'Geo started!'
  #     redirect_to locations_path
  # end

  def location_cleaner_btn
    # @service.delay.location_cleaner_btn
    @service.location_cleaner_btn
    redirect_to root_path
  end

  def geo_update_migrate_btn
    # @service.delay.geo_update_migrate_btn
    @service.geo_update_migrate_btn

    redirect_to root_path
  end

  def merge_data
    selects = params[:selects]
    rows = params[:rows]
    data_hash = id_merger(selects, rows)
    puts "\n\nmerge_data selects: #{selects.inspect}, rows: #{rows.inspect}\ndata_hash: #{data_hash.inspect}\n\n"

    if data_hash[:url].any?
      locations = Location.where(id: data_hash[:url])

      locations.each do |location|
        puts "\nURL #{location.id}\n"
        location.update_attributes(url_sts: "Merge", crm_url: location.url)
      end
    end

    if data_hash[:account].any?
      locations = Location.where(id: data_hash[:account])

      locations.each do |location|
        puts "\nACCT #{location.id}\n"
        location.update_attributes(acct_sts: "Merge", acct_name: location.geo_acct_name)
      end
    end

    if data_hash[:address].any?
      locations = Location.where(id: data_hash[:address])

      locations.each do |location|
        puts "\nADDRESS #{location.id}\n"
        location.update_attributes(addr_sts: "Merge", address: location.geo_full_addr, crm_street: location.street, crm_city: location.city, crm_state: location.state_code, crm_zip: location.postal_code)
      end
    end

    if data_hash[:phone].any?
      locations = Location.where(id: data_hash[:phone])

      locations.each do |location|
        puts "\nPHONE #{location.id}\n"
        location.update_attributes(ph_sts: "Merge", crm_phone: location.phone)
      end
    end
    flash[:notice] = "Merging Data Done!"
  end

  def flag_data
    selects = params[:selects]
    rows = params[:rows]
    data_hash = id_merger(selects, rows)
    puts "\n\nmerge_data selects: #{selects.inspect}, rows: #{rows.inspect}\ndata_hash: #{data_hash.inspect}\n\n"

    if data_hash[:url].any?
      locations = Location.where(id: data_hash[:url])

      locations.each do |location|
        puts "\nurl #{location.id}\n"
        location.update_attributes(url_sts: "Flag")
      end
    end

    if data_hash[:account].any?
      locations = Location.where(id: data_hash[:account])

      locations.each do |location|
        puts "\nacct #{location.id}\n"
        location.update_attributes(acct_sts: "Flag")
      end
    end

    if data_hash[:address].any?
      locations = Location.where(id: data_hash[:address])

      locations.each do |location|
        puts "\naddress #{location.id}\n"
        location.update_attributes(addr_sts: "Flag")
      end
    end

    if data_hash[:phone].any?
      locations = Location.where(id: data_hash[:phone])

      locations.each do |location|
        puts "\nphone #{location.id}\n"
        location.update_attributes(ph_sts: "Flag")
      end
    end
    flash[:notice] = "Flagging Data Done!"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:latitude, :longitude, :created_at, :updated_at, :city, :state, :state_code, :postal_code, :coordinates, :acct_name, :group_name, :ult_group_name, :source, :sfdc_id, :tier, :sales_person, :acct_type, :location_status, :url, :crm_root, :street, :address, :temporary_id, :geo_acct_name, :geo_full_addr, :phone, :map_url, :img_url, :place_id, :crm_source, :geo_root, :crm_root, :crm_url, :geo_franch_term, :geo_franch_cons, :geo_franch_cat, :crm_franch_term, :crm_franch_cons, :crm_franch_cat, :crm_phone, :crm_url_redirect, :geo_url_redirect, :sts_geo_crm, :sts_url, :sts_root, :sts_acct, :sts_addr, :sts_ph, :sts_duplicate)
  end

  def filtering_params(params)
    params.slice(:latitude, :longitude, :created_at, :updated_at, :city, :state, :state_code, :postal_code, :coordinates, :acct_name, :group_name, :ult_group_name, :source, :sfdc_id, :tier, :sales_person, :acct_type, :location_status, :url, :crm_root, :street, :address, :temporary_id, :geo_acct_name, :geo_full_addr, :crm_source, :geo_root, :crm_root, :crm_url, :geo_franch_term, :geo_franch_cons, :geo_franch_cat, :crm_franch_term, :crm_franch_cons, :crm_franch_cat, :crm_phone, :crm_url_redirect, :geo_url_redirect, :sts_geo_crm, :sts_url, :sts_root, :sts_acct, :sts_addr, :sts_ph, :sts_duplicate)
  end


  def set_location_service
    @service = LocationService.new
  end

  def batch_status
    ids = params[:multi_checks]
    return if ids.nil?
    status = params[:selected_status]
    for id in ids
      location = Location.find(id)
      location.update_attribute(:location_status, status)
      flash[:notice] = "Successfully updated"
    end

    destroy_rows(ids) if status == "Destroy"
  end

  def destroy_rows(ids)
    rows = Location.where(id: ids)
    rows.destroy_all
  end

  def id_merger(selects, ids)
    ids = [] if ids.nil?
    result = {url: ids, account: ids, address: ids, phone: ids}
    return result if selects.nil?

    selects.each do |key, value|
      result[key.to_sym] = (result[key.to_sym] + value).uniq
    end
    result
  end

  # Get dropdown option list from Dashboard
  def set_option_list
    @location_status_opts = ordered_list(grap_item_list("location_status"))
    @sts_geo_crm_opts = ordered_list(grap_item_list("sts_geo_crm"))
    @sts_url_opts = ordered_list(grap_item_list("sts_url"))
    @sts_acct_opts = ordered_list(grap_item_list("sts_acct"))
    @sts_addr_opts = ordered_list(grap_item_list("sts_addr"))
    @sts_ph_opts = ordered_list(grap_item_list("sts_ph"))
    @crm_source_opts = ordered_list(grap_item_list("crm_source"))
    @tier_opts = ordered_list(grap_item_list("tier"))
    @sales_person_opts = ordered_list(grap_item_list("sales_person"))
    @acct_type_opts = ordered_list(grap_item_list("acct_type"))
    # @state_opts = ordered_list(grap_item_list("state"))
    @state_opts = ordered_list(list_of_states)
  end

  def grap_item_list(col_name)
    Dashboard.find_by(db_name: "Location", col_name: col_name).item_list
  end

end
