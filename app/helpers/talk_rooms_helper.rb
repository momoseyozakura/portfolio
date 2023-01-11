module TalkRoomsHelper
  def most_new_message_preview(room)
    message = room.messages.order(updated_at: :desc).limit(1)
    message = message[0]
    tag.p "#{message.body}"
  end

  def message_preview_time(room)
    message = room.messages.order(updated_at: :desc).limit(1)
    message = message[0]
    tag.p "#{message.created_at.to_s(:datetime_jp)}", class: "time"
  end

  def opponent_user(room)
    entry = room.room_users.where.not(user_id: current_user)
    name = entry[0].user.name
    tag.p "#{name}"
  end

  def user_image(room)
    entry = room.room_users.where.not(user_id: current_user)
    image = entry[0].user.image
    if image.nil?
      image_tag "https://presite-potepancamp-rails-02.herokuapp.com/assets/default_icon-9263fc59c414b7228d256fc178dcb22183561357950a68f5ad086ba7ee054974.jpg", class: "icon-image"
    else
      image_tag "/user_images/#{image}", class: "icon-image"
    end
  end
end
