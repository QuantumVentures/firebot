class BackendAppComponentsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app
  before_action :find_component, only: %i(destroy show)

  def create
    component = Component.find_by id: params[:component_id]
    @app.add_component component
    flash[:success] = "Component added"
    redirect_to backend_app_components_path @app
  end

  def destroy
    @app.remove_component @component
    flash[:notice] = "Component removed"
    redirect_to backend_app_components_path @app
  end

  def index
    @components = include_subcomponents @app.components.order(name: :asc)
  end

  def new
    component_ids = @app.components.select(%i(id)).map(&:id)
    @components = include_subcomponents(
      Component.where.not(id: component_ids).order(name: :asc)
    )
  end

  def show
    @component     = @app.components.find_by id: params[:id]
    @subcomponents = @component.components
    @components    = @subcomponents + [@component]
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

  def find_component
    @component = @app.components.find_by id: params[:id]
    if @component.nil?
      flash[:notice] = "Component not found"
      redirect_to backend_app_components_path @app
    end
  end

  def include_subcomponents(collection)
    collection.map { |c| [c, c.components].compact }
  end
end
