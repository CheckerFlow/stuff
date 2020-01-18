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

  def shared_rooms(search = nil)
    shared_group_members = SharingGroupMember.where(:email => current_user.email)

    shared_list_ids = []

    shared_group_members.each do 
        |shared_group_member|
        if shared_group_member.shareable_type == "Room"
            shared_list_ids << shared_group_member.shareable.id
        end
    end  
    
    if search != nil
        _shared_rooms = Room.where(id: shared_list_ids).where('name LIKE ?', "%#{search}%") 
    else
        _shared_rooms = Room.where(id: shared_list_ids) 
    end
    
    return _shared_rooms        
  end    

  def all_rooms(search = nil)
    _family_member_rooms = family_member_rooms(search)
    _own_rooms = own_rooms(search)
    _shared_rooms = shared_rooms(search)

    all_rooms = _own_rooms + _family_member_rooms + _shared_rooms

    return all_rooms
  end
end
