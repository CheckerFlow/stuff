module ItemsHelper
    include StoragesHelper
    
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

    def shared_items(search = nil)
        shared_group_members = SharingGroupMember.where(:email => current_user.email)

        shared_item_ids = []

        shared_group_members.each do 
            |shared_group_member|
            if shared_group_member.shareable_type == "Item"
                shared_item_ids << shared_group_member.shareable.id
            end
        end  

        # Items through shared storages
        shared_storages.each do 
          |shared_storage|
          shared_storage.items.each do 
            |shared_storage_item|
            shared_item_ids << shared_storage_item.id
          end
        end            
        
        # Items through shared lists
        shared_lists.each do 
            |shared_list|
            shared_list.list_items.each do 
              |shared_list_item|
              shared_item_ids << shared_list_item.item.id
            end
          end             

        if search != nil
            _shared_items = Item.where(id: shared_item_ids).where('name LIKE ?', "%#{search}%") 
        else
            _shared_items = Item.where(id: shared_item_ids) 
        end

        return _shared_items        
    end    

    def all_items(search = nil)
        _family_member_items = family_member_items(search)
        _own_items = own_items(search)
        _shared_items = shared_items(search)

        all_items = _own_items + _family_member_items + _shared_items

        return all_items
    end 
  
end
