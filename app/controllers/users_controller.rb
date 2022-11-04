class UsersController < ApplicationController
  protect_from_forgery

  def show
    @user = User.find_by(id: params[:id])
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
