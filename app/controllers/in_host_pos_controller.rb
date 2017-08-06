class InHostPosController < ApplicationController
  before_action :admin_only
  before_action :set_in_host_po, only: [:show, :edit, :update, :destroy]

  # GET /in_host_pos
  # GET /in_host_pos.json
  def index
    # @in_host_pos = InHostPo.all

    @in_host_pos = InHostPo.order(:term)
    respond_to do |format|
      format.html
      format.csv { render text: @in_host_pos.to_csv }
    end

    #==== For multi check box
    selects = params[:multi_checks]
    unless selects.nil?
      InHostPo.where(id: selects).destroy_all
    end
    #================

  end

  # GET /in_host_pos/1
  # GET /in_host_pos/1.json
  def show
  end

  # GET /in_host_pos/new
  def new
    @in_host_po = InHostPo.new
  end


  # Go to the CSV importing page
  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    InHostPo.import_csv(file_name, InHostPo)

    flash[:notice] = "CSV imported successfully."
    redirect_to in_host_pos_path
  end


  # GET /in_host_pos/1/edit
  def edit
  end

  # POST /in_host_pos
  # POST /in_host_pos.json
  def create
    @in_host_po = InHostPo.new(in_host_po_params)

    respond_to do |format|
      if @in_host_po.save
        format.html { redirect_to @in_host_po, notice: 'In host po was successfully created.' }
        format.json { render :show, status: :created, location: @in_host_po }
      else
        format.html { render :new }
        format.json { render json: @in_host_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_host_pos/1
  # PATCH/PUT /in_host_pos/1.json
  def update
    respond_to do |format|
      if @in_host_po.update(in_host_po_params)
        format.html { redirect_to @in_host_po, notice: 'In host po was successfully updated.' }
        format.json { render :show, status: :ok, location: @in_host_po }
      else
        format.html { render :edit }
        format.json { render json: @in_host_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_host_pos/1
  # DELETE /in_host_pos/1.json
  def destroy
    @in_host_po.destroy
    respond_to do |format|
      format.html { redirect_to in_host_pos_url, notice: 'In host po was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_in_host_po
    @in_host_po = InHostPo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def in_host_po_params
    params.require(:in_host_po).permit(:term)
  end
end
