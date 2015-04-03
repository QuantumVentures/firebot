class BackendApp < ActiveRecord::Base
  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id

  belongs_to :user
end
