class Token < ActiveRecord::Base
  include ApplicationModel

  belongs_to :tokenable, polymorphic: true, touch: true
  belongs_to :user

  inheritable
  restoreable

  validates_presence_of :user

  before_create :generate_token, unless: :token?
  before_create :set_expiration, if: :lifespan

  class << self
    def active
      where "expires_at IS NULL OR expires_at > ?", Time.now
    end

    def most_recent
      active.order(updated_at: :desc).first
    end
  end

  def expire!
    touch(:expires_at) && destroy!
  end

  def expired?
    expires_at && expires_at < Time.now
  end

  def lifespan
  end

  def to_s
    token
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end

  def set_expiration
    self.expires_at = lifespan.from_now
  end
end
