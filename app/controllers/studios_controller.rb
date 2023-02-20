class StudiosController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @studios = Studio.all.includes(studio_users: :user)
  end

  def election
    @studios = Studio.all.includes(studio_users: :user)
  end

  def open
    User.update_all(open: "true")
    flash[:notice] = "公開しました。"
    redirect_to studios_election_path
  end

  def close
    User.update_all(open: "false")
    flash[:notice] = "非公開にしました。"
    redirect_to studios_election_path
  end

  def destroy
    StudioUser.destroy_all
    redirect_to studios_election_path
  end
end
