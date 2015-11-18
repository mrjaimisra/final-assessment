class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_links_path(current_user)
      flash[:success] = "#{@user.username} logged in."
    else
      redirect_to signin_path
      flash[:danger] = "Invalid login credentials."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end