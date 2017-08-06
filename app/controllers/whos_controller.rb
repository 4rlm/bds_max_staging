class WhosController < ApplicationController
  before_action :intermediate_and_up, only: [:index, :show, :search]
  before_action :advanced_and_up, only: [:edit, :update]
  before_action :admin_only, only: [:new, :create, :destroy, :import_page, :import_csv_data, :who_starter_btn, :who_power_btn]

  before_action :set_who, only: [:show, :edit, :update, :destroy]
  before_action :set_who_service, only: [:who_starter_btn, :import_page, :import_csv_data, :who_power_btn]
  before_action :set_option_list, only: [:index, :search]
  
  # GET /whos
  # GET /whos.json
  def index
    @whos = Who.all


    ## SET ORDER OF DISPLAYED DATA ##
    @whos = @whos.order(updated_at: :desc)
    @whos_count = Who.count
    @selected_whos_count = @whos.count

    # CSV #
    whos_csv = @whos.order(:domain)
    respond_to do |format|
      format.html
      format.csv { render text: whos_csv.to_csv }
    end


    # WILL_PAGINATE #
    @whos = @whos.filter(filtering_params(params)).paginate(:page => params[:page], :per_page => 20)

  end

  # GET /whos/1
  # GET /whos/1.json
  def show
  end

  # GET /whos/new
  def new
    @who = Who.new
  end


  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    Who.import_csv(file_name, Who, "who_status")

    flash[:notice] = "CSV imported successfully."
    redirect_to whos_path
  end

  def search
    @who_count = Who.count
  end


  # GET /whos/1/edit
  def edit
  end

  # POST /whos
  # POST /whos.json
  def create
    @who = Who.new(who_params)

    respond_to do |format|
      if @who.save
        format.html { redirect_to @who, notice: 'Who was successfully created.' }
        format.json { render :show, status: :created, location: @who }
      else
        format.html { render :new }
        format.json { render json: @who.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whos/1
  # PATCH/PUT /whos/1.json
  def update
    respond_to do |format|
      if @who.update(who_params)
        format.html { redirect_to @who, notice: 'Who was successfully updated.' }
        format.json { render :show, status: :ok, location: @who }
      else
        format.html { render :edit }
        format.json { render json: @who.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whos/1
  # DELETE /whos/1.json
  def destroy
    @who.destroy
    respond_to do |format|
      format.html { redirect_to whos_url, notice: 'Who was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  ############ BUTTONS ~ START ##############
  def who_starter_btn
    @who_service.who_starter
    #   @who_service.delay.who_starter
    redirect_to whos_path
  end

  def who_power_btn
    # @who_service..xxxx
    # @who_service.delay.xxxx
    redirect_to whos_path
  end

  ############ BUTTONS ~ END ##############




  private
  # Use callbacks to share common setup or constraints between actions.
  def set_who
    @who = Who.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def who_params
    params.require(:who).permit(:domain, :domain_id, :ip, :server1, :server2, :registrar_url, :registrar_id, :registrant_id, :registrant_type, :registrant_name, :registrant_organization, :registrant_address, :registrant_city, :registrant_zip, :registrant_state, :registrant_phone, :registrant_fax, :registrant_email, :registrant_url, :who_addr_pin)
  end

  def filtering_params(params)
    params.slice(:who_status, :url_status, :domain, :ip, :server1, :server2, :registrant_name, :registrant_organization, :registrant_address, :registrant_city, :registrant_state, :registrant_zip, :registrant_phone, :registrant_url, :who_addr_pin)
  end

  def set_who_service
    @who_service = WhoService.new
  end

  # Get dropdown option list from Dashboard
  def set_option_list
    @who_status_opts = ordered_list(grap_item_list("who_status"))
    @url_status_opts = ordered_list(grap_item_list("url_status"))
    # @state_opts = ordered_list(grap_item_list("state"))
    @state_opts = ordered_list(list_of_states)
  end

  def grap_item_list(col_name)
    Dashboard.find_by(db_name: "Who", col_name: col_name).item_list
  end

end
