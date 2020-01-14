class ListsController < ApplicationController
  include ApplicationHelper
  include ListsHelper

  include SharingGroupController

  before_action :authenticate_user!

  before_action :set_list, only: [:show, :edit, :update, :destroy, :selectitems, :addItem, :removeItem]

  before_action :set_list_as_resource, only: [:add_sharing_group_member, :remove_sharing_group_member, :sharing_group_members]

  before_action do 
    title("Listen")
  end  

  # GET /lists
  # GET /lists.json
  def index
    if params[:search]
      @lists = all_lists.where('name LIKE ?', "%#{params[:search]}%")
    else
      @lists = all_lists
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
    @list.user_id = current_user.id
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'Liste wurde erstellt.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'Liste wurde geändert.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to pages_home_path, notice: 'Liste wurde gelöscht.' }
      format.json { head :no_content }
    end
  end



  def addItem
    item = Item.find(params[:item_id])

    list_items = ListItem.where({item_id: params[:item_id], list_id: params[:id]})

    if (list_items.size > 0)
      respond_to do |format|
        format.html { redirect_to @list, notice: 'Gegenstand wurde der Liste schon hinzugefügt.' }
        format.json { head :no_content }
      end      
    elsif (item != nil)
      list_item = ListItem.new
      list_item.list_id = params[:id]
      list_item.item_id = item.id
      list_item.save

      respond_to do |format|
        format.html { redirect_to @list, notice: 'Gegenstand wurde zur Liste hinzugefügt.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to @list, notice: 'Kein Gegenstand selektiert. Kein Eintrag in die Liste erstellt.' }
        format.json { head :no_content }
      end
    end
  end

  def removeItem    
    list_items = ListItem.where({item_id: params[:item_id], list_id: params[:id]})

    if (list_items != nil)
      list_items.each do 
        |list_item|
        list_item.destroy
      end

      respond_to do |format|
        format.html { redirect_back(fallback_location: list_path(@list), notice: 'Gegenstand wurde von der Liste gelöscht.') }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @list, notice: 'Gegenstand nicht gefunden. Kein Gegenstand wurde von der Liste gelöscht.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Set the resource to be shared for the SharingGroupController. Note: Sharables are polymorphic
    def set_list_as_resource
      @resource = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name, :user_id, :search)
    end
end
