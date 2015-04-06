class Feature < Log
  validate :loggable_is_backend_app

  private

  def loggable_is_backend_app
    if loggable.class != BackendApp
      errors.add :loggable, "must be a BackendApp"
    end
  end
end
