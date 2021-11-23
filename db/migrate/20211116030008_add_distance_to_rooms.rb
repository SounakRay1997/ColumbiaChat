class AddDistanceToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :distance, :float, default: 0.0
  end
end
