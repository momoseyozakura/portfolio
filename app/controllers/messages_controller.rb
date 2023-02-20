class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if RoomUser.where(user_id: current_user.id,
                      talk_room_id: params[:message][:talk_room_id]).present?
      @message = Message.create(message_params)
      redirect_to talk_room_path(@message.talk_room_id)
    else
      flash[:alert] = "メッセージの送信に失敗しました。"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :talk_room_id, :body).merge(user_id: current_user.id)
  end
end
