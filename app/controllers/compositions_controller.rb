class CompositionsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app

  def create
    composition = Composition.new permitted.merge({ composable: @app })
    if composition.save
      flash[:success] = "Component added"
      redirect_to index_backend_app_components_path @app
    else
      flash[:error] = "You already added this component"
      redirect_to new_backend_app_components_path(@app)
    end
  end

  def destroy
    comp = @app.compositions.find_by component_id: params[:component_id]
    comp.destroy
    flash[:success] = "Component removed"
    redirect_to index_backend_app_components_path @app
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

  def permitted_params
    %i(component_id)
  end
end
