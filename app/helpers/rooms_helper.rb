module RoomsHelper
  def items_count(room)
    if room.storages.size > 0
      return room.storages.sum(&:items).count
    else 
      return 0
    end
  end

  def own_rooms(search = nil)
    if search != nil
        return current_user.rooms.where('name LIKE ?', "%#{search}%")
    else
        return current_user.rooms
    end
  end

  def family_member_rooms(search = nil)
      family_members = FamilyMember.where(:email => current_user.email)

      family_members_user_ids = []

      family_members.each do 
          |family_member|            
          family_members_user_ids << family_member.user_id
      end    
      
      if search != nil
          _family_member_rooms = Room.where(user_id: family_members_user_ids).where('name LIKE ?', "%#{search}%") 
      else
          _family_member_rooms = Room.where(user_id: family_members_user_ids) 
      end
      
      return _family_member_rooms
  end

  def all_rooms(search = nil)
      _family_member_rooms = family_member_rooms(search)
      _own_rooms = own_rooms(search)

      if _family_member_rooms != nil
          all_rooms = _family_member_rooms + _own_rooms
      else 
          all_rooms = _own_rooms
      end

      return all_rooms
  end  
end
