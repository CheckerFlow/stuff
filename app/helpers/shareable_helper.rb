module ShareableHelper

    def is_shared(resource)

        # A resource is shared with the current user if there is a sharing group member of the resource corresponding to the current user's email
        resource.sharing_group_members.each do 
            |sharing_group_member|
            if sharing_group_member.email == current_user.email
                return true
            end
        end

        # An item is shared if the storage in which it is contained is shared
        if resource.class == Item
            item_is_shared = false

            resource.lists.each do 
                |list|
                item_is_shared = item_is_shared || is_shared(list)
            end

            item_is_shared = item_is_shared || is_shared(resource.storage) 

            return item_is_shared
        end

        if resource.class == Storage
            return is_shared(resource.room)
        end

        if resource.class == Room
            return is_shared(resource.building)
        end

        return false
    end
  
end