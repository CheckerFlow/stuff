class ListItemsController < ApplicationController
    before_action :authenticate_user!

    def create
        @list_item = ListItem.new
        puts "*" *50
        puts params[:list_item]
        puts params[:list_item][:list_id]
        puts params[:list_item][:item_id]

        @list_item.list_id = params[:list_item][:list_id]
        @list_item.item_id = params[:list_item][:item_id]
        puts "*" *50

        respond_to do |format|
            if @list_item.save
                format.html { redirect_back(fallback_location: items_path, notice: 'Gegenstand wurde erfolgreich der Liste hinzugefügt.')  }
                format.json { render :show, status: :created, location: @list_item }
            else
                format.html { render :new }
                format.json { render json: @list_item.errors, status: :unprocessable_entity }
            end
        end
    end

    def index 
        @list_items = ListItem.all

        @list_items.each do 
            |list_item|
            #list_item.destroy
        end

        @list_items = ListItem.all
    end
    
    private

        # Never trust parameters from the scary internet, only allow the white list through.
        def list_item_params
            params.require(:list_item).permit(:list_id, item_id)
        end    
end
