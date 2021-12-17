require 'rails_helper'

describe RoomsController, type: :controller do

    it 'creates a new room' do
      new_room = "my_new_room"
      x = Room.create(distance: 10.0, name: new_room, is_private: true, lat: 0, long: 0)
      puts Room.all
      rooms = []
      Room.all.each do |s|
        rooms.append(s.name)
      end
      expect(rooms).to include(new_room)
      
    end

    it 'creates a new room not discoverable to everyone' do
      new_room = "my_new_room"
      x = Room.create(distance: 1.0, name: new_room, is_private: true, lat: 40.8028039, long: -73.965221)
      expect(x.isInRadius(x.lat, x.long, 40.8136855, -73.9622017, x.distance)).to be_falsey

    end

    it 'creates a new room discoverable to everyone' do
      new_room = "my_new_room"
      x = Room.create(distance: 100000.0, name: new_room, is_private: true, lat: 40.8028039, long: -73.965221)
      expect(x.isInRadius(x.lat, x.long, 40.8136855, -73.9622017, x.distance)).to be_truthy

    end


end 
