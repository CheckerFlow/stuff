class AddBuildingIdToRooms < ActiveRecord::Migration[6.0]
  def up
    add_column :rooms, :building_id, :integer

    User.all.each do 
      |user|
      
      default_building = Building.new
      default_building.name = "Mein erstes Gebäude"
      default_building.user_id = user.id
      default_building.save

      user.rooms.each do 
        |room|
        room.building_id = default_building.id
        room.save
      end        
    
    end
  end

  def down
    remove_column :rooms, :building_id, :integer
  end
end
