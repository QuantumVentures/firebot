class BackendApp < ActiveRecord::Base
  include ApplicationModel

  restoreable

  has_many :access_tokens, as: :tokenable
  has_many :features,      as: :loggable
  has_many :logs,          as: :loggable

  belongs_to :user

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id
end
