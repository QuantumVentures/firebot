class Component < ActiveRecord::Base
  include ApplicationModel

  # has_many :backend_apps, through: :packages
  has_many :models, dependent: :destroy
  # has_many :packages

  validates_presence_of :name
  validates_uniqueness_of :name
end
