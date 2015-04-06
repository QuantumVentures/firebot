module BackendAppFindable
  extend ActiveSupport::Concern

  def backend_app_id_key
    :id
  end

  def find_app
    @app = current_user.apps.find_by id: params[backend_app_id_key]
    if @app.nil?
      flash[:error] = "App not found"
      redirect_to new_backend_app_path
    end
  end
end
