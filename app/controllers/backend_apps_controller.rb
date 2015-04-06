class BackendAppsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app, only: %i(status)

  def create
    @app = current_user.apps.new permitted
    if @app.save
      flash[:success] = "App successfully created"
      redirect_to new_backend_app_feature_path @app
    else
      @errors = stringify_single_error @app.errors
      @title  = "New App"
      render "new"
    end
  end

  def new
    @app   = current_user.apps.new
    @title = "New App"
  end

  def status
    @title = "Status"
  end

  private

  def permitted_params
    %i(description name)
  end
end
