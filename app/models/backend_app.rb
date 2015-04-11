class BackendApp < ActiveRecord::Base
  include ApplicationModel

  restoreable

  with_options dependent: :destroy do
    has_many :access_tokens, as: :tokenable
    has_many :features,      as: :loggable
    has_many :logs,          as: :loggable
    has_many :models
  end

  belongs_to :user

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id

  before_create :set_uid

  private

  def set_uid
    self.uid = SecureRandom.uuid.split("-").join ""
  end
end
