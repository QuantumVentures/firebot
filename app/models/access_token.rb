class AccessToken < Token
  before_create :set_metadata
  before_create :set_tokenable_uid

  def lifespan
    12.months
  end

  private

  def set_metadata
    if tokenable && tokenable.metadata.present?
      self.metadata = tokenable.metadata
    end
  end

  def set_tokenable_uid
    if tokenable && tokenable.try(:uid)
      self.tokenable_uid = tokenable.uid
    end
  end
end
