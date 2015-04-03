class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_path
    else
      @errors = "Invalid email and/or password"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def new
    @title = "Login"
  end
end
