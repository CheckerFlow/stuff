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
    
      def all_lists(search = nil)
          _family_member_lists = family_member_lists(search)
          _own_lists = own_lists(search)
    
          if _family_member_lists != nil
              all_lists = _family_member_lists + _own_lists
          else 
              all_lists = _own_lists
          end
    
          return all_lists
      end      
end
