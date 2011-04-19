class UsersController < ApplicationController
  def index
  end

  def create
    user = User.new
    user.nickname = params[:user][:nickname]
    if user.save
      session[:user_id] = user.id
      redirect_to board_path
    else
      flash[:notice] = "DAI CAZZO!"
    end
  end

end
