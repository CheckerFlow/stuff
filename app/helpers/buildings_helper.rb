module BuildingsHelper

    def own_buildings(search = nil)
        if search != nil
            return current_user.buildings.where('name LIKE ?', "%#{search}%")
        else
            return current_user.buildings
        end
    end

    def family_member_buildings(search = nil)
        family_members = FamilyMember.where(:email => current_user.email)

        family_members_user_ids = []

        family_members.each do 
            |family_member|            
            family_members_user_ids << family_member.user_id
        end    
        
        if search != nil
            _family_member_buildings = Building.where(user_id: family_members_user_ids).where('name LIKE ?', "%#{search}%") 
        else
            _family_member_buildings = Building.where(user_id: family_members_user_ids) 
        end
        
        return _family_member_buildings
    end

    def shared_buildings(search = nil)
        shared_group_members = SharingGroupMember.where(:email => current_user.email)

        shared_list_ids = []

        shared_group_members.each do 
            |shared_group_member|
            if shared_group_member.shareable_type == "Building"
                shared_list_ids << shared_group_member.shareable.id
            end
        end  
        
        if search != nil
            _shared_buildings = Building.where(id: shared_list_ids).where('name LIKE ?', "%#{search}%") 
        else
            _shared_buildings = Building.where(id: shared_list_ids) 
        end
        
        return _shared_buildings        
    end    

    def all_buildings(search = nil)
        _family_member_buildings = family_member_buildings(search)
        _own_buildings = own_buildings(search)
        _shared_buildings = shared_buildings(search)

        all_buildings = _own_buildings + _family_member_buildings + _shared_buildings

        return all_buildings
    end
end
