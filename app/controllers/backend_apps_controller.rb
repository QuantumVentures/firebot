class BackendAppsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app, only: %i(show status)

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

  def index
    @apps  = current_user.apps
    @title = "Apps"
  end

  def new
    @app   = current_user.apps.new
    @title = "New App"
  end

  def show
    @title = @app.name
  end

  def status
    @completed = features.completed.order(completed_at: :desc).limit(3).decorate
    @incompleted = features.incompleted.order(created_at: :asc).decorate
    @status = @incompleted.present? ? "Adding new features" : "Ready for use"
    @title  = "Status"
  end

  private

  def features
    @app.features
  end

  def permitted_params
    %i(description name)
  end
end
