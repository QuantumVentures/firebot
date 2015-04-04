class BackendAppsController < ApplicationController
  before_action :require_login
  before_action :find_app, only: :describe

  def create
    @app = current_user.apps.new permitted
    if @app.save
      redirect_to describe_backend_app_path @app
    else
      @errors = stringify_single_error @app.errors
      render "new"
    end
  end

  def describe
    if @app
      @title = "Describe"
    else
      flash[:error] = "App not found"
      redirect_to new_backend_app_path
    end
  end

  def new
    @app   = current_user.apps.new
    @title = "New App"
  end

  private

  def find_app
    @app = current_user.apps.find_by id: params[:id]
  end

  def permitted
    params.require(:backend_app).permit :description, :name
  end
end
