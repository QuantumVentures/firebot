class Feature < Log
  validate :loggable_is_backend_app
  validates_presence_of :responsible

  private

  def loggable_is_backend_app
    if loggable.class != BackendApp
      errors.add :loggable, "must be a BackendApp"
    end
  end
end
