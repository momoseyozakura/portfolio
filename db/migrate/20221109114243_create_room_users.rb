class CreateRoomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :room_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :talk_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
