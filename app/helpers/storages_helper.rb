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

    def all_storages(search = nil)
        _family_member_storages = family_member_storages(search)
        _own_storages = own_storages(search)

        if _family_member_storages != nil
            all_storages = _family_member_storages + _own_storages
        else 
            all_storages = _own_storages
        end

        return all_storages
    end      
end
