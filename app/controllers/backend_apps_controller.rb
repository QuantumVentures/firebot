class BackendAppsController < ApplicationController
  before_action :require_login

  def new
    @title = "New App"
  end
end
