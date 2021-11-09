class UsersController < ApplicationController
  
  def register
    @user = User.new
  end

  def create
    session[:user_id] = User.create(user_params).id
    redirect_to "/"
  end

  def login
    @user = User.new
  end

  def authenticate
    redirect_after_login(User.find_by(username: params[:username]))
  end

  def logout
    session[:user_id] = nil
    redirect_to "/login"
  end

  private 

  def user_params
    params.require(:user).permit(:username, :full_name, :password, :profile_photo)
  end

  def redirect_after_login(user)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/posts'
    else
      redirect_to '/login'
    end
  end

end