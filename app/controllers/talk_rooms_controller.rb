class TalkRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @talk_room = current_user.talk_rooms
  end

  def create
    @room = TalkRoom.create
    @join_current_user = RoomUser.create(user_id: current_user.id, talk_room_id: @room.id)
    @join_user = RoomUser.create(join_room_params)
    redirect_to talk_room_path(@room.id)
  end

  def show
    @room = TalkRoom.find(params[:id])
    if RoomUser.where(user_id: current_user.id, talk_room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
      @message = Message.new
      @room_users = @room.room_users
      @receive_user = @room_users.where.not(user_id: current_user.id).first
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def join_room_params
    params.require(:room_user).permit(:user_id, :talk_room_id).merge(talk_room_id: @room.id)
  end
end
