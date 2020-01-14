module SharingGroupController
    extend ActiveSupport::Concern

    def sharing_group
        @sharing_group_members = @resource.sharing_group_members
    end

    def add_sharing_group_member    
        email = params[:sharing_group_member][:email]

        sharing_group_member = SharingGroupMember.new
        sharing_group_member.email = email
        sharing_group_member.user_id = current_user.id
        sharing_group_member.shareable = @resource
        sharing_group_member.save

        respond_to do |format|
        format.html { redirect_to sharing_group_list_path(@resource), notice: email + ' wurde der Teilen-Gruppe hinzugefügt.' }
        format.json { head :no_content }
        end 
    end

    def remove_sharing_group_member
        sharing_group_member = SharingGroupMember.find(params[:sharing_group_member_id])
        sharing_group_member.destroy

        respond_to do |format|
        format.html { redirect_back(fallback_location: sharing_group_list_path(@resource), notice: sharing_group_member.email + ' wurde der Teilen-Gruppe entfernt.') }
        format.json { head :no_content }
        end    
    end
end