class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def cleanup
    @rooms = current_user.rooms.all

    rooms = Room.where(user_id: nil).each do 
      |room| 
      room.user_id = current_user.id
      room.save
    end

    storages = Storage.where(user_id: nil).each do 
      |storage| 
      storage.user_id = current_user.id
      storage.save
    end    

    items = Item.where(user_id: nil).each do 
      |item| 
      item.user_id = current_user.id
      item.save
    end        

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: items.count.to_s + ' orphaned items successfully cleaned up.' }
    end
  end

  # GET /rooms
  # GET /rooms.json
  def index
    if params[:search]
      @rooms = current_user.rooms.where('name LIKE ?', "%#{params[:search]}%")
    else
      @rooms = current_user.rooms.all
    end    
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @storages = @room.storages.all
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @room.user_id = current_user.id
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id

    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_url, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update    
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_url, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    
    @room.images.each do 
      |image|
      image.purge
    end

    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = current_user.rooms.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:user_id, :name, :search, images: [])
    end
end
