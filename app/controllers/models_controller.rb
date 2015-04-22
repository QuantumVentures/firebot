class ModelsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app
  before_action :find_model, only: %i(edit update)

  def create
    @model = @app.models.new permitted
    if @model.valid?
      add_column
      @model.save
      flash[:success] = "Model created"
      redirect_to backend_app_models_path @app
    else
      @errors = stringify_single_error @model.errors
      render "new"
    end
  end

  def edit
  end

  def index
    @models = @app.models
  end

  def new
    @model = @app.models.new
  end

  def update
    @model.assign_attributes permitted
    if @model.valid?
      add_column
      @model.save
      flash[:success] = "Model saved"
      redirect_to backend_app_models_path @app
    else
      @errors = stringify_single_error @model.errors
      render "edit"
    end
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

  def find_model
    @model = @app.models.find_by id: params[:id]
    if @model.nil?
      flash[:error] = "Model not found"
      redirect_to backend_app_models_path @app
    end
  end

  def permitted_params
    %i(name)
  end

  def add_column
    @model.add_column params[:name], {
      relationship_to: params[:relationship_to],
      required:        params[:required].nil? ? false : true,
      type:            params[:type]
    }
  end
end
