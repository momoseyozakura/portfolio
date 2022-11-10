class UsersController < ApplicationController
  protect_from_forgery

  def show
    @user = User.find_by(id: params[:id])
    @current_room_user = RoomUser.where(user_id: current_user.id)
    @receive_user = RoomUser.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_room_user.each do |current|
        @receive_user.each do |recieve|
          if current.talk_room_id == recieve.talk_room_id
            @have_room = true
            @room_id = current.talk_room_id
          end
        end
      end
      unless @have_room
        @room = TalkRoom.new
        @room_user = RoomUser.new
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    if params[:image]
      @user.image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image}",image.read)
    end
    @user.member = params[:member]
    
    if @user.save
      redirect_to("/")
    else
      render :edit
    end
  end
end
