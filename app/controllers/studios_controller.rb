class StudiosController < ApplicationController
  def index
    @studios = Studio.all
  end

  def election
    @studios = Studio.all
  end

  def open
    User.update_all(open: "true" )
    flash[:notice] = "公開しました。"
    redirect_to studios_election_path
  end

  def close
    User.update_all(open: "false" )
    flash[:notice] = "非公開にしました。"
    redirect_to studios_election_path
  end

  def destroy
    StudioUser.destroy_all
    redirect_to studios_election_path
  end
  
end
