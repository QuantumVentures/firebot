class ComponentsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app

  def app_index
    @components = include_subcomponents @app.components.order(name: :asc)
  end

  def app_new
    component_ids = @app.components.select(%i(id)).map(&:id)
    @components = include_subcomponents(
      Component.where.not(id: component_ids).order(name: :asc)
    )
  end

  def app_show
    @component     = @app.components.find params[:id]
    @subcomponents = @component.components
    @components    = @subcomponents + [@component]
  end

  private

  def backend_app_id_key
    :backend_app_id
  end

  def include_subcomponents(collection)
    collection.map { |c| [c, c.components].compact }
  end
end
