module ListsHelper
    def own_lists(search = nil)
    if search != nil
        return current_user.lists.where('name LIKE ?', "%#{search}%")
    else
        return current_user.lists
    end
    end

    def family_member_lists(search = nil)
        family_members = FamilyMember.where(:email => current_user.email)

        family_members_user_ids = []

        family_members.each do 
            |family_member|            
            family_members_user_ids << family_member.user_id
        end    
        
        if search != nil
            _family_member_lists = List.where(user_id: family_members_user_ids).where('name LIKE ?', "%#{search}%") 
        else
            _family_member_lists = List.where(user_id: family_members_user_ids) 
        end
        
        return _family_member_lists
    end

    def shared_lists(search = nil)
        shared_group_members = SharingGroupMember.where(:email => current_user.email)

        shared_list_ids = []

        shared_group_members.each do 
            |shared_group_member|
            if shared_group_member.shareable_type == "List"
                shared_list_ids << shared_group_member.shareable.id
            end
        end  

        if search != nil
            _shared_lists = List.where(id: shared_list_ids).where('name LIKE ?', "%#{search}%") 
        else
            _shared_lists = List.where(id: shared_list_ids) 
        end

        return _shared_lists        
    end    

    def all_lists(search = nil)
        _family_member_lists = family_member_lists(search)
        _own_lists = own_lists(search)
        _shared_lists = shared_lists(search)

        all_lists = _own_lists + _family_member_lists + _shared_lists

        return all_lists
    end
end
