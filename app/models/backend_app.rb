class BackendApp < ActiveRecord::Base
  include ApplicationModel

  restoreable

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id

  has_many :features, as: :loggable
  has_many :logs,     as: :loggable

  belongs_to :user
end
