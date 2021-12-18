class Room < ApplicationRecord
    validates_uniqueness_of :name
    scope :public_rooms, -> {where(is_private: false)}
    scope :dept_rooms, ->(dept) { where(dept_code: dept) }
    has_many :messages
    has_many :participants, dependent: :destroy
    # after_create_commit { broadcast_if_public }
    after_create_commit { broadcast_append_to self }


#  def broadcast_if_public
#   userId = self.user_id
#   user = User.find(userId)
#   broadcast_append_to "rooms" unless self.is_private || !isInRadius(user.lat, user.long, self.lat, self.long, self.distance)
#   broadcast_append_to "rooms" unless self.is_private 
#  end

 def isInRadius(lat1, lon1, user_lat, user_long, roomDist) 
  dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
  dis_feet = dis_miles * 5280.0
  dis_feet <= roomDist 
  
end

def getDistanceFromRoom(room, user)
  lat1 = room.lat
  lon1 = room.long
  user_lat = user.lat
  user_long = user.long
  dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
  dis_feet = dis_miles * 5280.0
  return dis_feet.round
end


 def self.create_private_room(users, room_name)
  single_room = Room.create(name: room_name, is_private: true)
  users.each do |user|
    Participant.create(user_id: user.id, room_id: single_room.id )
  end
  single_room
 end
end
