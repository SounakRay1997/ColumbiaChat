class AddUserIdToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :user_id, :integer, default: 3
  end
end
