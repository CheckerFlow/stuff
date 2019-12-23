class StoragesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_storage, only: [:show, :edit, :update, :destroy, :edit_images]
  before_action :set_room, only: [:new, :create]

  # GET /storages
  # GET /storages.json
  def index
    if params[:search]
      @storages = current_user.storages.where('name LIKE ?', "%#{params[:search]}%")
    else
      @storages = current_user.storages.all
    end
  end

  # GET /storages/1
  # GET /storages/1.json
  def show
    # Redirect images#show if storage has images. 
    if @storage.images.size > 0
      redirect_to storage_image_path(@storage, @storage.images.first)
    end
  end

  # GET /storages/new
  def new
    @storage = Storage.new
    @storage.user_id = current_user.id
  end

  # GET /storages/1/edit
  def edit
    @room = @storage.room    
  end

  def edit_images
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.attachments.first.purge
    redirect_back(fallback_location: rooms_path)
  end  

  # POST /storages
  # POST /storages.json
  def create
    @storage = @room.storages.new(storage_params)
    @storage.user_id = current_user.id

    respond_to do |format|
      if @storage.save
        format.html { redirect_to @storage, notice: 'Ablage wurde erfolgreich erstellt.' }
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
        format.html { redirect_to room_url(@storage.room), notice: 'Ablage wurde erfolgreich geändert.' }
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
      format.html { redirect_to room_url(@room), notice: 'Ablage wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storage
      @storage = current_user.storages.find(params[:id])
    end

    def set_room
      @room = current_user.rooms.find(params[:room_id])
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def storage_params
      params.require(:storage).permit(:user_id, :name, :search, :room_id, images: [])
    end
end
