class UsersController < ApplicationController
  def create
    @user = User.new permitted
    if @user.save
      log_in @user
      redirect_to root_path
    else
      @errors = stringify_errors(@user.errors)
      render "new"
    end
  end

  def new
    @title = "Sign up"
    @user  = User.new
  end

  private

  def stringify_errors(errors)
    error = errors.first
    error[0].to_s.split("_").join(" ").capitalize + " #{error[1]}"
  end

  def permitted
    params.require(:user).permit(:email, :full_name, :password)
  end
end
