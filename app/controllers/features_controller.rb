class FeaturesController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app

  def create
    if descriptions_array
      create_features
      flash[:success] = "Features successfully saved"
      redirect_to status_backend_app_path @app
    else
      @errors = "You must describe at least 1 feature"
      render "new"
    end
  end

  def new
    @features = @app.features.first
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

  def create_features
    descriptions_array.each do |description|
      @app.features.create description: description, responsible: current_user
    end
  end

  def descriptions_array
    if params[:descriptions].present?
      params[:descriptions].split(".").map(&:strip)
    end
  end
end
