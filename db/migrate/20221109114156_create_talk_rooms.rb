class CreateTalkRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :talk_rooms do |t|

      t.timestamps
    end
  end
end
