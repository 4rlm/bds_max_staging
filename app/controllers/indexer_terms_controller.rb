class IndexerTermsController < ApplicationController
  before_action :admin_only
  before_action :set_indexer_term, only: [:show, :edit, :update, :destroy]

  # GET /indexer_terms
  # GET /indexer_terms.json
  def index
    @indexer_terms = IndexerTerm.all

    @indexer_terms = IndexerTerm.order(:category)
    respond_to do |format|
      format.html
      format.csv { render text: @indexer_terms.to_csv }
    end

  end

  # GET /indexer_terms/1
  # GET /indexer_terms/1.json
  def show
  end

  # GET /indexer_terms/new
  def new
    @indexer_term = IndexerTerm.new
  end

  # Go to the CSV importing page
  def import_page
  end

  def import_csv_data
    file_name = params[:file]
    IndexerTerm.import_csv(file_name, IndexerTerm)

    flash[:notice] = "CSV imported successfully."
    redirect_to indexer_terms_path

  end

  # GET /indexer_terms/1/edit
  def edit
  end

  # POST /indexer_terms
  # POST /indexer_terms.json
  def create
    @indexer_term = IndexerTerm.new(indexer_term_params)

    respond_to do |format|
      if @indexer_term.save
        format.html { redirect_to @indexer_term, notice: 'Indexer term was successfully created.' }
        format.json { render :show, status: :created, location: @indexer_term }
      else
        format.html { render :new }
        format.json { render json: @indexer_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indexer_terms/1
  # PATCH/PUT /indexer_terms/1.json
  def update
    respond_to do |format|
      if @indexer_term.update(indexer_term_params)
        format.html { redirect_to @indexer_term, notice: 'Indexer term was successfully updated.' }
        format.json { render :show, status: :ok, location: @indexer_term }
      else
        format.html { render :edit }
        format.json { render json: @indexer_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indexer_terms/1
  # DELETE /indexer_terms/1.json
  def destroy
    @indexer_term.destroy
    respond_to do |format|
      format.html { redirect_to indexer_terms_url, notice: 'Indexer term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_indexer_term
    @indexer_term = IndexerTerm.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def indexer_term_params
    params.require(:indexer_term).permit(:category, :sub_category, :criteria_term, :response_term, :criteria_count, :response_count)
  end
end
