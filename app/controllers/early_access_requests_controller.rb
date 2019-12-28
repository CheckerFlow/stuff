class EarlyAccessRequestsController < ApplicationController
  before_action :set_early_access_request, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  before_action do 
    title("Registrierung")
  end    

  # GET /early_access_requests
  # GET /early_access_requests.json
  def index
    @early_access_requests = EarlyAccessRequest.all
  end

  # GET /early_access_requests/1
  # GET /early_access_requests/1.json
  def show
  end

  # GET /early_access_requests/new
  def new
    @early_access_request = EarlyAccessRequest.new
  end

  # GET /early_access_requests/1/edit
  def edit
  end

  # POST /early_access_requests
  # POST /early_access_requests.json
  def create
    @early_access_request = EarlyAccessRequest.new(early_access_request_params)

    respond_to do |format|
      if @early_access_request.save
        format.html { redirect_to root_path, notice: 'Danke für die Registrierung. Wir melden uns bei dir.' }
        format.json { render :show, status: :created, location: @early_access_request }
      else
        format.html { render :new }
        format.json { render json: @early_access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /early_access_requests/1
  # PATCH/PUT /early_access_requests/1.json
  def update
    respond_to do |format|
      if @early_access_request.update(early_access_request_params)
        format.html { redirect_to @early_access_request, notice: 'Anfrage wurde geändert.' }
        format.json { render :show, status: :ok, location: @early_access_request }
      else
        format.html { render :edit }
        format.json { render json: @early_access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /early_access_requests/1
  # DELETE /early_access_requests/1.json
  def destroy
    @early_access_request.destroy
    respond_to do |format|
      format.html { redirect_to early_access_requests_url, notice: 'Anfrage wurde gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_early_access_request
      @early_access_request = EarlyAccessRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def early_access_request_params
      params.require(:early_access_request).permit(:email)
    end
end
