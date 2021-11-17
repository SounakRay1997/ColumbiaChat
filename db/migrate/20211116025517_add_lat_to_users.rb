class AddLatToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lat, :float, default: 0.0
    add_column :users, :long, :float, default: 0.0
  end
end
