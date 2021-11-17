class AddLatToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :lat, :float, default: 0.0
    add_column :rooms, :long, :float, default: 0.0
  end
end
