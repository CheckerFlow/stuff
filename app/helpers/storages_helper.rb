module StoragesHelper
    def own_storages(search = nil)
        if search != nil
            return current_user.storages.where('name LIKE ?', "%#{search}%")
        else
            return current_user.storages
        end
    end

    def family_member_storages(search = nil)
        family_members = FamilyMember.where(:email => current_user.email)

        family_members_user_ids = []

        family_members.each do 
            |family_member|            
            family_members_user_ids << family_member.user_id
        end    
        
        if search != nil
            _family_member_storages = Storage.where(user_id: family_members_user_ids).where('name LIKE ?', "%#{search}%") 
        else
            _family_member_storages = Storage.where(user_id: family_members_user_ids) 
        end
        
        return _family_member_storages
    end

    def shared_storages(search = nil)
        shared_group_members = SharingGroupMember.where(:email => current_user.email)
    
        shared_list_ids = []
    
        shared_group_members.each do 
            |shared_group_member|
            if shared_group_member.shareable_type == "Storage"
                shared_list_ids << shared_group_member.shareable.id
            end
        end  
        
        if search != nil
            _shared_storages = Storage.where(id: shared_list_ids).where('name LIKE ?', "%#{search}%") 
        else
            _shared_storages = Storage.where(id: shared_list_ids) 
        end
        
        return _shared_storages        
      end    
    
      def all_storages(search = nil)
        _family_member_storages = family_member_storages(search)
        _own_storages = own_storages(search)
        _shared_storages = shared_storages(search)
    
        all_storages = _own_storages + _family_member_storages + _shared_storages
    
        return all_storages
      end     
end
