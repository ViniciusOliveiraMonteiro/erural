class AddVideoIdToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :video_id, :string
  end
end
