class RoomsController < ApplicationController
  include ActiveStorage::SendZip
  include ApplicationHelper
  include RoomsHelper
  require 'will_paginate/array'  
  include SharingGroupController  

  before_action :authenticate_user!

  before_action :set_room, only: [:show, :edit, :update, :destroy, :edit_images, :download_image_attachments]

  before_action :set_resource, only: [:add_sharing_group_member, :remove_sharing_group_member, :sharing_group_members]  
  
  before_action do 
    title("Räume")
  end

  # GET /rooms
  # GET /rooms.json
  def index
    if params[:search]
      #@rooms = current_user.rooms.where('name LIKE ?', "%#{params[:search]}%")
      #@rooms = current_user.rooms.where('name LIKE ?', "%#{params[:search]}%").paginate(page: params[:page])
      @rooms = all_rooms(params[:search]).paginate(page: params[:page])

      @buildings = all_buildings
    else
      #@rooms = current_user.rooms.all
      #@rooms = current_user.rooms.all.paginate(page: params[:page])
      @rooms = all_rooms.paginate(page: params[:page])

      @buildings = all_buildings
    end    
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @storages = @room.storages.all

    process_images(@room)
  end

  def download_image_attachments

    respond_to do |format|
      format.html { redirect_back(fallback_location: room_path(@room), notice: 'Als ZIP Format anfragen.') }
      format.zip { send_zip @room.images }
    end
    
  end  

  # GET /rooms/new
  def new
    @room = Room.new
    @room.user_id = current_user.id
  end

  # GET /rooms/1/edit
  def edit
  end

  def edit_images
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.attachments.first.purge
    redirect_back(fallback_location: rooms_path)
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    
    if (room_params[:building_id] == nil || room_params[:building_id] == "")
      default_building = current_user.buildings.first
      @room.building_id = default_building.id
    else 
      @room.building_id = room_params[:building_id]
    end

    respond_to do |format|
      if @room.save

        process_images(@room)

        format.html { redirect_to @room.building, notice: 'Raum wurde erstellt.' }
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

        process_images(@room)

        format.html { redirect_to room_url(@room), notice: 'Raum wurde geändert.' }
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
      format.html { redirect_to rooms_url, notice: 'Raum wurde gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Set the resource to be shared for the SharingGroupController. Note: Sharables are polymorphic
    def set_resource
      @resource = Room.find(params[:room_id])
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:user_id, :building_id, :name, :search, images: [])
    end
end
