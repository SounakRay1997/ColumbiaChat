class Room < ApplicationRecord
    validates_uniqueness_of :name
    scope :public_rooms, -> {where(is_private: false)}
    has_many :messages
    has_many :participants, dependent: :destroy
    after_create_commit { broadcast_if_public
                          broadcast_to_users_if_private
     }

 def broadcast_if_public
  broadcast_append_to "rooms" unless self.is_private
 end

 def broadcast_to_users_if_private
  puts "potato2"
  puts Participant.where(room_id: Room.where(name: self.name).ids[0]).ids
  # private_users = Participant.joins(:user).where(users: {room_id: Participant.joins(:room).where(rooms: {name: self.name})})
  private_users = Participant.where(room_id: Room.where(name: self.name).ids[0])
  # private_users = Participant.where(room_id: Room.where(name: self.name).pluck(:id)).pluck(:user_id)
  if self.is_private
    private_users.each do |user|
      broadcast_append_to "rooms"
    end
  end
 end

 def self.create_private_room(users, room_name)
  single_room = Room.create(name: room_name, is_private: true)
  users.each do |user|
    Participant.create(user_id: user.id, room_id: single_room.id )
  end
  single_room
 end
end
