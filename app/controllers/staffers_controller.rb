class StaffersController < ApplicationController
  before_action :intermediate_and_up, only: [:index, :show, :search, :acct_contacts]
  before_action :advanced_and_up, only: [:edit, :update]
  before_action :admin_only, only: [:new, :create, :destroy, :import_page, :import_csv_data, :staffer_sfdc_id_cleaner_btn, :cs_data_getter_btn, :staffer_power_btn, :crm_staff_counter_btn]
  before_action :set_staffer, only: [:show, :edit, :update, :destroy]
  before_action :set_staffer_service, only: [:staffer_sfdc_id_cleaner_btn, :cs_data_getter_btn, :staffer_power_btn, :crm_staff_counter_btn]
  before_action :set_option_list, only: [:index, :search]

  # GET /staffers
  # GET /staffers.json

  def index
    if choice_hash = get_selected_status_staffer
      clean_choice_hash = {}
      @view_mode = choice_hash[:view_mode]

      choice_hash.each do |key, value|
        clean_choice_hash[key] = value if !value.nil? && value != "" && key != :view_mode
      end
      @selected_data = Staffer.where(clean_choice_hash)
    else # choice_hash is nil
      @selected_data = Staffer.all.order(updated_at: :desc)
    end

    if url = params[:url]
      @selected_data = @selected_data.where(domain: url).order(updated_at: :desc)
    else
      @selected_data = @selected_data.order(updated_at: :desc)
    end
    @staffer_count = Staffer.count
    @selected_staffer_count = @selected_data.count

    # CSV #
    respond_to do |format|
      format.html
      format.csv { render text: @selected_data.to_csv }
    end

    @staffers = @selected_data.filter(filtering_params(params)).paginate(:page => params[:page], :per_page => 40)

    batch_status
  end

  # GET /staffers/1
  # GET /staffers/1.json
  def show
  end

  # GET /staffers/new
  def new
    @staffer = Staffer.new
  end

  # Go to the CSV importing page
  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    Staffer.import_csv(file_name, Staffer, "staffer_status")

    flash[:notice] = "CSV imported successfully."
    redirect_to staffers_path
  end


  # GET /staffers/1/edit
  def edit
  end

  def search
    @staffer_count = Staffer.count
  end


  # POST /staffers
  # POST /staffers.json
  def create
    @staffer = Staffer.new(staffer_params)

    respond_to do |format|
      if @staffer.save
        format.html { redirect_to @staffer, notice: 'Staffer was successfully created.' }
        format.json { render :show, status: :created, location: @staffer }
      else
        format.html { render :new }
        format.json { render json: @staffer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffers/1
  # PATCH/PUT /staffers/1.json
  def update
    respond_to do |format|
      if @staffer.update(staffer_params)
        format.html { redirect_to @staffer, notice: 'Staffer was successfully updated.' }
        format.json { render :show, status: :ok, location: @staffer }
      else
        format.html { render :edit }
        format.json { render json: @staffer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffers/1
  # DELETE /staffers/1.json
  def destroy
    @staffer.destroy
    respond_to do |format|
      format.html { redirect_to staffers_url, notice: 'Staffer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def acct_contacts
    if core_id = params[:core]
      @core = Core.find(core_id)
      @staffers = Staffer.where(sfdc_id: @core.sfdc_id)
    else
      indexer = Indexer.find(params[:indexer])
      @staffers = Staffer.where(domain: indexer.clean_url)
    end
  end

  def crm_staff_counter_btn
    @staffer_service.crm_staff_counter
    # @staffer_service.delay.crm_staff_counter
    redirect_to cores_path
  end


  def staffer_sfdc_id_cleaner_btn
    # @staffer_service.staffer_sfdc_id_cleaner

    # @staffer_service.staffer_core_updater
    # @staffer_service.delay.staffer_core_updater


    redirect_to root_path
  end


  ############## ATTENTION!!! ###############
  ### NEED TO REFACTOR THIS AFTER TESTING ###

  ### Step 1 of Staffer Scraper - Starts Here
  def cs_data_getter_btn
    ## Need to change name of this method and btn to starter, which calls the starter method which calls the cs_data_getter method in batches, based on template, then cuts into smaller jobs of 25 indexers each (25 urls.)

    # @staffer_service.cs_data_getter
    # @staffer_service.delay.cs_data_getter

    @staffer_service.cs_starter

    redirect_to indexers_path
    # redirect_to admin_path
  end

  ##########################################


  # ========== Temporary/Power Button ==========

  def staffer_power_btn
    # @staffer_service.fname_cleaner
    # @staffer_service.delay.fname_cleaner

    redirect_to indexers_path
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_staffer
    @staffer = Staffer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def staffer_params
    params.require(:staffer).permit(:staffer_status, :cont_status, :cont_source, :sfdc_id, :sfdc_sales_person, :sfdc_type, :sfdc_cont_id, :staffer_date, :created_at, :updated_at, :sfdc_tier, :domain, :acct_name, :street, :city, :state, :zip, :fname, :lname, :fullname, :job, :job_raw, :phone, :email, :full_address, :acct_pin, :cont_pin)
  end

  def filtering_params(params)
    params.slice(:staffer_status, :cont_status, :cont_source, :sfdc_id, :sfdc_sales_person, :sfdc_type, :sfdc_cont_id, :staffer_date, :created_at, :updated_at, :sfdc_tier, :domain, :acct_name, :street, :city, :state, :zip, :fname, :lname, :fullname, :job, :job_raw, :phone, :email, :full_address, :acct_pin, :cont_pin)
  end

  def batch_status
    ids = params[:multi_checks]
    return if ids.nil?
    status = params[:selected_status]
    for id in ids
      staff = Staffer.find(id)
      staff.update_attribute(:staffer_status, status)
      flash[:notice] = "Successfully updated"

      # *** Uncomment after Core Migration new staffer columns
      # core = Core.find_by(sfdc_id: staffer.sfdc_id)
      # core.update_attribute(:staffer_status, status)
    end

    destroy_rows(ids) if status == "Destroy"
  end

  def destroy_rows(ids)
    rows = Staffer.where(id: ids)
    rows.destroy_all
  end

  def set_staffer_service
    @staffer_service = StafferService.new
  end

  # Get dropdown option list from Dashboard
  def set_option_list
    @staffer_status_opts = ordered_list(grap_item_list("staffer_status"))
    @cont_source_opts = ordered_list(grap_item_list("cont_source"))
    @sfdc_type_opts = ordered_list(grap_item_list("sfdc_type"))
    @sfdc_tier_opts = ordered_list(grap_item_list("sfdc_tier"))
    @sfdc_sales_person_opts = ordered_list(grap_item_list("sfdc_sales_person"))
    @cont_status_opts = ordered_list(grap_item_list("cont_status"))
    @job_opts = ordered_list(grap_item_list("job"))
    # @state_opts = ordered_list(grap_item_list("state"))
    @state_opts = ordered_list(list_of_states)
    @email_status = ordered_list(email_status_list)
  end

  def grap_item_list(col_name)
    Dashboard.find_by(db_name: "Staffer", col_name: col_name).item_list
  end


end
