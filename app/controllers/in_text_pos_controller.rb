class InTextPosController < ApplicationController
  # Hide all CRUD actions 2017.03.10
  # So all CRUD actions are only accessible to admin only for now.
  before_action :admin_only

  before_action :set_in_text_po, only: [:show, :edit, :update, :destroy]
  
  # GET /in_text_pos
  # GET /in_text_pos.json
  def index
    # @in_text_pos = InTextPo.all

    @in_text_pos = InTextPo.order(:term)
    respond_to do |format|
      format.html
      format.csv { render text: @in_text_pos.to_csv }
    end

    #==== For multi check box
    selects = params[:multi_checks]
    unless selects.nil?
      InTextPo.where(id: selects).destroy_all
    end
    #================

  end

  # GET /in_text_pos/1
  # GET /in_text_pos/1.json
  def show
  end

  # GET /in_text_pos/new
  def new
    @in_text_po = InTextPo.new
  end

  # Go to the CSV importing page
  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    InTextPo.import_csv(file_name)

    flash[:notice] = "CSV imported successfully."
    redirect_to in_text_pos_path
  end

  # GET /in_text_pos/1/edit
  def edit
  end

  # POST /in_text_pos
  # POST /in_text_pos.json
  def create
    @in_text_po = InTextPo.new(in_text_po_params)

    respond_to do |format|
      if @in_text_po.save
        format.html { redirect_to @in_text_po, notice: 'In text po was successfully created.' }
        format.json { render :show, status: :created, location: @in_text_po }
      else
        format.html { render :new }
        format.json { render json: @in_text_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_text_pos/1
  # PATCH/PUT /in_text_pos/1.json
  def update
    respond_to do |format|
      if @in_text_po.update(in_text_po_params)
        format.html { redirect_to @in_text_po, notice: 'In text po was successfully updated.' }
        format.json { render :show, status: :ok, location: @in_text_po }
      else
        format.html { render :edit }
        format.json { render json: @in_text_po.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_text_pos/1
  # DELETE /in_text_pos/1.json
  def destroy
    @in_text_po.destroy
    respond_to do |format|
      format.html { redirect_to in_text_pos_url, notice: 'In text po was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_in_text_po
    @in_text_po = InTextPo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def in_text_po_params
    params.require(:in_text_po).permit(:term)
  end
end
