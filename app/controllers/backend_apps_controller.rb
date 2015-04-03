class BackendAppsController < ApplicationController
  before_action :require_login

  def create
    @app = current_user.apps.new permitted
    if @app.save
      redirect_to root_path
    else
      @errors = stringify_single_error @app.errors
      render "new"
    end
  end

  def new
    @app   = current_user.apps.new
    @title = "New App"
  end

  private

  def permitted
    params.require(:backend_app).permit :description, :name
  end
end
