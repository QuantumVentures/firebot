class ModelsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app
  before_action :find_model, only: %i(destroy edit remove_column update)

  def create
    @model = @app.models.new permitted
    add_column if params[:name]
    if @model.save
      flash[:success] = "Model created"
      redirect_to backend_app_models_path @app
    else
      @errors = stringify_single_error @model.errors
      render "new"
    end
  end

  def destroy
    @model.destroy
    redirect_to backend_app_models_path @app
  end

  def edit
  end

  def index
    @models = @app.models.order(name: :asc).decorate
  end

  def new
    @model = @app.models.new
  end

  def remove_column
    @model.remove_column params[:name]
    @model.save
    flash[:success] = "Column removed"
    redirect_to edit_backend_app_model_path(@app, @model)
  end

  def update
    add_column if params[:name]
    if @model.update permitted
      flash[:success] = "Model updated"
      redirect_to edit_backend_app_model_path(@app, @model)
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
    %i(description name)
  end

  def add_column
    @model.add_column params[:name], {
      relationship_to: params[:relationship_to],
      required:        params[:required].nil? ? false : true,
      type:            params[:type]
    }
  end
end
