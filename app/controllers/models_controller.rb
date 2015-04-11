class ModelsController < ApplicationController
  include BackendAppFindable

  before_action :require_login
  before_action :find_app

  def create
  end

  def destroy
  end

  def edit
  end

  def index
  end

  def new
    @title = "New Model"
  end

  def update
  end

  private

  def backend_app_id_key
    :backend_app_id
  end
end
