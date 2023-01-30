class AddUuidToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :uuid, :string
  end
end
