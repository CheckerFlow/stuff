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

    def all_buildings(search = nil)
        _family_member_buildings = family_member_buildings(search)
        _own_buildings = own_buildings(search)

        if _family_member_buildings != nil
            all_buildings = _family_member_buildings + _own_buildings
        else 
            all_buildings = _own_buildings
        end

        return all_buildings
    end
end
