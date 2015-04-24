class BackendAppsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app, only: %i(documentation edit show status update)

  def create
    @app = current_user.apps.new permitted
    if @app.save
      flash[:success] = "App successfully created"
      redirect_to backend_app_path @app
    else
      @errors = stringify_single_error @app.errors
      render "new"
    end
  end

  def documentation
  end

  def edit
  end

  def index
    @apps = current_user.apps.order(name: :asc).decorate
  end

  def new
    @app = current_user.apps.new
  end

  def show
  end

  def status
    @completed = features.completed.order(completed_at: :desc).limit(3).decorate
    @incompleted = features.incompleted.order(created_at: :asc).decorate
    @status = @incompleted.present? ? "Adding new features" : "Ready for use"
  end

  def update
    if @app.update permitted
      flash[:success] = "Update succeeded"
      redirect_to backend_app_path(@app)
    else
      @errors = stringify_single_error @app.errors
      render "edit"
    end
  end

  private

  def features
    @app.features
  end

  def permitted_params
    %i(description name)
  end
end
