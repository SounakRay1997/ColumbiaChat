require 'rails_helper'

describe RoomsController, type: :controller do

    it 'creates a new room' do
      new_room = "my_new_room"
      x = post(:create, params: {room: { name: new_room }} )  
      rooms = []
      Room.all.each do |s|
        rooms.append(s.name)
      end
      expect(rooms).to include(new_room)
      
    end

end 
