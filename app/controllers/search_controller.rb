class SearchController < ApplicationController
  include ApplicationHelper

  before_action do 
    title("Suchen")
  end    
  
  before_action :authenticate_user!

  def search
    if params[:search_string] != "" && params[:search_string] != nil
      @rooms = current_user.rooms.where('name LIKE ?', "%#{params[:search_string]}%")
      @storages = current_user.storages.where('name LIKE ?', "%#{params[:search_string]}%")
      @items = current_user.items.where('name LIKE ?', "%#{params[:search_string]}%")
      @lists = current_user.lists.where('name LIKE ?', "%#{params[:search_string]}%")

      @items_tagged = Item.tagged_with(params[:search_string])

    else
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
