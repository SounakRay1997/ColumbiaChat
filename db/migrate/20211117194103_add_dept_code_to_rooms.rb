class AddDeptCodeToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :dept_code, :string, default: "NONE"
  end
end
