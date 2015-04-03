module Sessionable
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    redirect_to(new_user_path) unless logged_in?
  end

  def require_logout
    redirect_to(root_path) if logged_in?
  end
end
