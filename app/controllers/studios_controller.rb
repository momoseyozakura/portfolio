class StudiosController < ApplicationController
  def index
    @studios = Studio.all
  end

  def election
    @studios = Studio.all
  end

  def destroy
    StudioUser.destroy_all
    redirect_to studios_path
  end
  
end
