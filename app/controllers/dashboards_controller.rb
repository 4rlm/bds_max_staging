class DashboardsController < ApplicationController
  before_action :intermediate_and_up, only: [:index, :show, :summarize_data]
  before_action :admin_only, only: [:new, :create, :edit, :update, :destroy, :dashboard_mega_btn, :cores_dash_btn, :whos_dash_btn, :delayed_jobs_dash_btn, :franchise_dash_btn, :indexer_dash_btn, :geo_locations_dash_btn, :staffers_dash_btn, :users_dash_btn, :whos_dash_btn, :import_page, :import_csv_data, :dashboard_power_btn]
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  before_action :set_dashboard_service, only: [:dashboard_mega_btn, :cores_dash_btn, :whos_dash_btn, :delayed_jobs_dash_btn, :franchise_dash_btn, :indexer_dash_btn, :geo_locations_dash_btn, :staffers_dash_btn, :users_dash_btn, :whos_dash_btn, :import_page, :import_csv_data, :summarize_data, :dashboard_power_btn]
  
  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all.order(:db_name, :col_name, :col_alias)
    # @dashboards = Dashboard.all


    # CSV #
    dashboards_csv = @dashboards.order(:db_name)
    respond_to do |format|
      format.html
      format.csv { render text: dashboards_csv.to_csv }
    end


    # # Core All
    # @core_all = Core.count
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    Dashboard.import_csv(file_name, Dashboard)

    flash[:notice] = "CSV imported successfully."
    redirect_to dashboards_path
  end


  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def summarize_data
    @core_data = @service.render_summarize_data("Core", ["sfdc_acct_url", "sfdc_clean_url", "sfdc_ult_grp_id"])
    @core_cols = grap_col_names("Core")
    @staffer_data = @service.render_summarize_data("Staffer", ["sfdc_id", "sfdc_cont_id", "domain", "acct_name"])
    @staffer_cols = grap_col_names("Staffer")
    @indexer_data = @service.render_summarize_data("Indexer", ["acct_name", "zip", "acct_pin"])
    @indexer_cols = grap_col_names("Indexer")
    @who_data = @service.render_summarize_data("Who", ["domain", "registrar_url", "registrant_name", "admin_organization"])
    @who_cols = grap_col_names("Who")
    @location_data = @service.render_summarize_data("Location", ["acct_name", "sfdc_id", "url", "crm_url_redirect"])
    @location_cols = grap_col_names("Location")
  end

  ############ BUTTONS ~ START ##############
  def dashboard_mega_btn
    @service.mega_dash
    # @service.delay.mega_dash
    redirect_to dashboards_path
  end

  def cores_dash_btn
    # @service.delay.dash(Core)
    # @service.delay.list_getter(Core, [:alt_source, :bds_status, :staff_pf_sts, :loc_pf_sts, :staffer_sts, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :sfdc_state, :sfdc_franch_cons, :sfdc_franch_cat, :template, :acct_merge_sts, :acct_match_sts, :alt_state, :match_score, :ph_match_sts, :pin_match_sts, :redirect_sts, :url_match_sts, :who_sts, :alt_template])
    @service.dash(Core)
    @service.list_getter(Core, [:alt_source, :bds_status, :staff_pf_sts, :loc_pf_sts, :staffer_sts, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :sfdc_state, :sfdc_franch_cons, :sfdc_franch_cat, :template, :acct_merge_sts, :acct_match_sts, :alt_state, :match_score, :ph_match_sts, :pin_match_sts, :redirect_sts, :url_match_sts, :who_sts, :alt_template])
    redirect_to dashboards_path
  end

  def franchise_dash_btn
    # @service.delay.dash(InHostPo)
    # @service.delay.list_getter(InHostPo, [:consolidated_term, :category])
    @service.dash(InHostPo)
    @service.list_getter(InHostPo, [:consolidated_term, :category])
    redirect_to dashboards_path
  end

  def indexer_dash_btn
    # @service.delay.dash(Indexer)
    # @service.delay.list_getter(Indexer, [:redirect_status, :indexer_status, :who_status, :rt_sts, :cont_sts, :loc_status, :stf_status, :contact_status, :template, :state])
    @service.dash(Indexer)
    @service.list_getter(Indexer, [:redirect_status, :indexer_status, :who_status, :rt_sts, :cont_sts, :loc_status, :stf_status, :contact_status, :template, :state])
    redirect_to dashboards_path
  end

  def geo_locations_dash_btn
    # @service.delay.dash(Location)
    # @service.delay.list_getter(Location, [:location_status, :sts_duplicate, :sts_geo_crm, :sts_url, :sts_acct, :sts_addr, :sts_ph, :crm_source, :tier, :sales_person, :acct_type, :url_sts, :acct_sts, :addr_sts, :ph_sts])
    @service.dash(Location)
    @service.list_getter(Location, [:location_status, :sts_duplicate, :sts_geo_crm, :sts_url, :sts_acct, :sts_addr, :sts_ph, :crm_source, :tier, :sales_person, :acct_type, :url_sts, :acct_sts, :addr_sts, :ph_sts])
    redirect_to dashboards_path
  end

  def staffers_dash_btn
    # @service.delay.dash(Staffer)
    # @service.delay.list_getter(Staffer, [:staffer_status, :cont_source, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :cont_status, :job, :state])
    @service.dash(Staffer)
    @service.list_getter(Staffer, [:staffer_status, :cont_source, :sfdc_type, :sfdc_tier, :sfdc_sales_person, :cont_status, :job, :state])
    redirect_to dashboards_path
  end

  def whos_dash_btn
    # @service.delay.dash(Who)
    # @service.delay.list_getter(Who, [:who_status, :url_status])
    @service.dash(Who)
    @service.list_getter(Who, [:who_status, :url_status])
    redirect_to dashboards_path
  end

  # def delayed_jobs_dash_btn
  ### PROBLEM.  NOT RUNNING.
  #     @service.delayed_jobs_dash
  #     # @service.delay.delayed_jobs_dash
  #
  #     redirect_to dashboards_path
  # end

  def dashboard_power_btn
    # @service.delay.item_list_to_hash
    # @service.item_list_to_hash
    # @service.delay.new_cols_creater
    # @service.new_cols_creater(Core)
    # @service.new_cols_creater(Indexer)
    # @service.new_cols_creater(Location)
    # @service.new_cols_creater(Staffer)
    # @service.new_cols_creater(Who)
    # @service.new_cols_creater(InHostPo)
    # @service.old_cols_remover(Core)
    # @service.old_cols_remover(Indexer)
    # @service.old_cols_remover(Location)
    # @service.old_cols_remover(Staffer)
    # @service.old_cols_remover(Who)
    # @service.old_cols_remover(InHostPo)
    redirect_to dashboards_path
  end

  ############ BUTTONS ~ END ##############


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dashboard
    @dashboard = Dashboard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dashboard_params
    params.require(:dashboard).permit(:db_name, :db_alias, :col_name, :col_alias)
  end

  def set_dashboard_service
    @service = DashboardService.new
  end

  def grap_col_names(db_name)
    Dashboard.where(db_name: db_name).map(&:col_name)
  end

end
