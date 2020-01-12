class SearchController < ApplicationController
  include ApplicationHelper
  include BuildingsHelper
  include RoomsHelper
  include StoragesHelper
  include ItemsHelper
  include ListsHelper

  before_action do 
    title("Suchen")
  end    
  
  before_action :authenticate_user!

  def search
    if params[:search_string] != "" && params[:search_string] != nil
      #@buildings = current_user.buildings.where('name LIKE ?', "%#{params[:search_string]}%")
      #@rooms = current_user.rooms.where('name LIKE ?', "%#{params[:search_string]}%")
      #@storages = current_user.storages.where('name LIKE ?', "%#{params[:search_string]}%")
      #@items = current_user.items.where('name LIKE ?', "%#{params[:search_string]}%")
      #@lists = current_user.lists.where('name LIKE ?', "%#{params[:search_string]}%")

      @buildings = all_buildings(params[:search_string])
      @rooms = all_rooms(params[:search_string])
      @storages = all_storages(params[:search_string])
      @items = all_items(params[:search_string])
      @lists = all_lists(params[:search_string])

      @items_tagged = Item.tagged_with(params[:search_string])

    else
      @buildings = nil
      @rooms = nil
      @storages = nil
      @items = nil
      @lists = nil

      @items_tagged = nil
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:search_string)
    end  
end
