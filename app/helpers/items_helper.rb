module ItemsHelper
    def own_items(search = nil)
        if search != nil
            return current_user.items.where('name LIKE ?', "%#{search}%")
        else
            return current_user.items
        end
    end

    def family_member_items(search = nil)
        family_members = FamilyMember.where(:email => current_user.email)

        family_members_user_ids = []

        family_members.each do 
            |family_member|            
            family_members_user_ids << family_member.user_id
        end    
        
        if search != nil
            _family_member_items = Item.where(user_id: family_members_user_ids).where('name LIKE ?', "%#{search}%") 
        else
            _family_member_items = Item.where(user_id: family_members_user_ids) 
        end
        
        return _family_member_items
    end

    def all_items(search = nil)
        _family_member_items = family_member_items(search)
        _own_items = own_items(search)

        if _family_member_items != nil
            all_items = _family_member_items + _own_items
        else 
            all_items = _own_items
        end

        return all_items
    end      
end
