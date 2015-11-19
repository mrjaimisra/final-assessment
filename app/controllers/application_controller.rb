class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_user,
                :current_link_status
  :authorize!

  def current_user
    @current_user ||= User.find_by(id: session[:user]) if session[:user]
  end

  def current_link_status(link)
    if link.status
      "read"
    else
      "unread"
    end
  end

  def authorize!
    unless authorized?
      redirect_to user_links_path(current_user)
      flash[:danger] = "You are not authorized to visit this page"
    end
  end
end
