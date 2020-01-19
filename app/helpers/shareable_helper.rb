module ShareableHelper
    def is_shared(resource)        

        if resource.sharing_group_members.size == 0
            return false
        else
            resource.sharing_group_members.each do 
                |sharing_group_member|

                if sharing_group_member.user_id == current_user.id
                    return true
                end
            end
        end
        
        return false
    end         
end