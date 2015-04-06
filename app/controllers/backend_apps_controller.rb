class BackendAppsController < ApplicationController
  before_action :require_login
  before_action :find_app, only: %i(describe descriptions status)

  def create
    @app = current_user.apps.new permitted
    if @app.save
      flash[:success] = "App successfully created"
      redirect_to descriptions_backend_app_path @app
    else
      @errors = stringify_single_error @app.errors
      @title  = "New App"
      render "new"
    end
  end

  def describe
    if descriptions_array
      create_logs
      flash[:success] = "Features successfully saved"
      redirect_to status_backend_app_path @app
    else
      @errors = "You must describe at least 1 feature"
      @title  = "Describe"
      render "descriptions"
    end
  end

  def descriptions
    @title = "Descriptions"
  end

  def new
    @app   = current_user.apps.new
    @title = "New App"
  end

  def status
    @title = "Status"
  end

  private

  def create_logs
    descriptions_array.each do |description|
      @app.logs.create description: description, responsible: current_user
    end
  end

  def descriptions_array
    if params[:descriptions].present?
      params[:descriptions].split(".").map(&:strip)
    end
  end

  def find_app
    @app = current_user.apps.find_by id: params[:id]
    if @app.nil?
      flash[:error] = "App not found"
      redirect_to new_backend_app_path
    end
  end

  def permitted_params
    %i(description name)
  end
end
