class SessionsController < ApplicationController
  before_action :require_login,  only: :logout
  before_action :require_logout, only: %i(create login)

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_path
    else
      @errors = "Invalid email and/or password"
      render "login"
    end
  end

  def login
  end

  def logout
    log_out
    redirect_to root_path
  end
end
