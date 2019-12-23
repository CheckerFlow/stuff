class ImagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_storage

    def index
        if (@storage != nil)
            @images = @storage.images
        else
            @images = []
        end
    end

    def show
        if (@storage != nil && params[:id] != nil)
            @image = @storage.images.find(params[:id])
            
            @next_image = @storage.images.attachments.where("id > ?", @image.id).first
            @previous_image = @storage.images.attachments.where("id < ?", @image.id).last

            @first_image = @storage.images.attachments.first
            @last_image = @storage.images.attachments.last

        else
            @image = nil            
        end
    end

    private
      def set_storage
        if (params[:storage_id] != nil)
            @storage = current_user.storages.find(params[:storage_id])
        else
            @storage = nil
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def images_params
        params.fetch(:item, {})
        params.require(:image).permit(:storage_id, :id)
      end        
end