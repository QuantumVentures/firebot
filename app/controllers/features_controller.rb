class FeaturesController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app

  def create
    if descriptions_array
      create_logs
      flash[:success] = "Features successfully saved"
      redirect_to status_backend_app_path @app
    else
      @errors = "You must describe at least 1 feature"
      @title  = "New Features"
      render "new"
    end
  end

  def new
    @title = "New Features"
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

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
end
