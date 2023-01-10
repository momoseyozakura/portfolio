module TalkRoomsHelper
  # 最新メッセージのデータを取得して表示するメソッド
  def most_new_message_preview(room)
    # 最新メッセージのデータを取得する
    message = room.messages.order(updated_at: :desc).limit(1)
    # 配列から取り出す
    message = message[0]
    # メッセージの有無を判定
    if message.present?
      # メッセージがあれば内容を表示
      tag.p "#{message.body}"
    else
      # メッセージがなければ[ まだメッセージはありません ]を表示
      tag.p "[ まだメッセージはありません ]"
    end
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
