class UsersController < ApplicationController
  
  def register
    @user = User.new
  end

  def create
    session[:user_id] = User.create(params.require(:user).permit(:username, :full_name, :password)).id
    redirect_to "/"
  end

  def login
    @user = User.new
  end

  def authenticate
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to "/login"
  end

end