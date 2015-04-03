class UsersController < ApplicationController
  before_action :require_logout

  def create
    @user = User.new permitted
    if @user.save
      log_in @user
      redirect_to new_backend_app_path
    else
      @errors = stringify_single_error @user.errors
      render "new"
    end
  end

  def new
    @title = "Sign up"
    @user  = User.new
  end

  private

  def permitted
    params.require(:user).permit :email, :full_name, :password
  end
end
