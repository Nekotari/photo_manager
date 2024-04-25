class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    errors = []
    if params[:user][:id].empty?
      errors << "Please enter User ID"
    end
    if params[:user][:password].empty?
      errors << "Please enter Password"
    end

    @user = User.find_by(id: params[:user][:id])

    if errors.any?
      flash[:alert] = errors
      redirect_to new_user_session_path
    elsif @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = ["User ID or Password wrong"]
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
