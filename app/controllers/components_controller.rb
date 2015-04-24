class ComponentsController < ApplicationController
  include BackendAppFindable

  before_action :require_login, only: %i(app_index)
  before_action :find_app, only: %i(app_index)

  def app_index

  end

  def index
  end

  private

  def backend_app_id_key
    :backend_app_id
  end
end
