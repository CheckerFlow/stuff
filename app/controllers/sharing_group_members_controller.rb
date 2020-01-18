class SharingGroupMembersController < ApplicationController

    before_action :authenticate_user!

    before_action :set_sharing_group_member, only: [:destroy]

    def index
        @sharing_group_members = current_user.sharing_group_members
    end

    # DELETE /items/1
    # DELETE /items/1.json
    def destroy
        @sharing_group_member.destroy
            respond_to do |format|
            format.html { redirect_to sharing_group_members_url, notice: 'Teilen wurde gelöscht.' }
            format.json { head :no_content }
        end
    end    

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_sharing_group_member
            @sharing_group_member = SharingGroupMember.find(params[:id])
        end    

        # Never trust parameters from the scary internet, only allow the white list through.
        def sharing_group_member_params
            params.fetch(:sharing_group_member, {})
            params.require(:sharing_group_member).permit(:user_id)
        end        
end