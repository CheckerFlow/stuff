module RoomsHelper
  def items_count(room)
    if room.storages.size > 0
      return room.storages.sum(&:items).count
    else 
      return 0
    end
  end
end
