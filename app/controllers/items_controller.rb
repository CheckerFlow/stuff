class ItemsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_item, only: [:show, :edit, :update, :destroy, :edit_images]
  before_action :set_storage, only: [:new, :create, :edit, :index]

  # GET /items
  # GET /items.json
  def index
    if @storage
      @items = @storage.items
    else
      if params[:search]
        @items = current_user.items.where('name LIKE ?', "%#{params[:search]}%")
      else
        @items = current_user.items.all
      end
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @list_item = ListItem.new    
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.user_id = current_user.id
  end

  # GET /items/1/edit
  def edit
  end

  def edit_images
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.attachments.first.purge
    redirect_back(fallback_location: rooms_path)
  end    

  # POST /items
  # POST /items.json
  def create
    @item = @storage.items.new(item_params)
    @item.user_id = current_user.id

    # Attach image from storage to item (if image_id is passed)
    if (params[:image_id] != nil && params[:image_id] != "")
      image = @storage.images.find(params[:image_id])
      @item.images.attach(image.blob)
    end

    @item.tag_list = ""
    @item.tag_list = Twitter::TwitterText::Extractor.extract_hashtags(item_params[:name])

    @item.owner_list = ""
    @item.owner_list = Twitter::TwitterText::Extractor.extract_mentioned_screen_names(item_params[:name])
    
    respond_to do |format|
      if @item.save
        format.html { redirect_back(fallback_location: items_path, notice: 'Gegenstand wurde erfolgreich erstellt.')  }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update

    @item.tag_list = ""
    @item.tag_list = Twitter::TwitterText::Extractor.extract_hashtags(item_params[:name])

    @item.owner_list = ""
    @item.owner_list = Twitter::TwitterText::Extractor.extract_mentioned_screen_names(item_params[:name])

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_back(fallback_location: items_path, notice: 'Gegenstand wurde erfolgreich geändert.') }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: items_path, notice: 'Gegenstand wurde erfolgreich gelöscht.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_user.items.find(params[:id])
    end

    def set_storage 
      if params[:storage_id]
        @storage = current_user.storages.find(params[:storage_id])
      else
        @storage = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      puts "*" * 50
      puts params
      puts "*" * 50

      params.fetch(:item, {})
      params.require(:item).permit(:user_id, :name, :description, :storage_id, :search, :image, images: [])
    end
end
