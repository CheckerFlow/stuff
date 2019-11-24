class StoragesController < ApplicationController
  before_action :set_storage, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:new, :create, :index]

  # GET /storages
  # GET /storages.json
  def index
    @storages = Storage.all
  end

  # GET /storages/1
  # GET /storages/1.json
  def show
  end

  # GET /storages/new
  def new
    @storage = Storage.new
  end

  # GET /storages/1/edit
  def edit
    @room = @storage.room
    puts @room.id
  end

  # POST /storages
  # POST /storages.json
  def create
    @storage = @room.storages.new(storage_params)

    respond_to do |format|
      if @storage.save
        format.html { redirect_to room_url(@room), notice: 'Storage was successfully created.' }
        format.json { render :show, status: :created, location: @storage }
      else
        format.html { render :new }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storages/1
  # PATCH/PUT /storages/1.json
  def update
    respond_to do |format|
      if @storage.update(storage_params)
        format.html { redirect_to room_url(@storage.room), notice: 'Storage was successfully updated.' }
        format.json { render :show, status: :ok, location: @storage }
      else
        format.html { render :edit }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storages/1
  # DELETE /storages/1.json
  def destroy
    @room = @storage.room
    @storage.destroy
    respond_to do |format|
      format.html { redirect_to room_url(@room), notice: 'Storage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storage
      @storage = Storage.find(params[:id])
    end

    def set_room
      @room = Room.find(params[:room_id])
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def storage_params
      params.require(:storage).permit(:name)
    end
end
