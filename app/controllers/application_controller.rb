class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  private

  def require_login
    if current_user.nil?
      flash[:error] = ["You must be logged in to access this section"]
      redirect_to root_path
    end
  end
end
