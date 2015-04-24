class PaymentMethod < ActiveRecord::Base
  include ApplicationModel

  inheritable

  belongs_to :liable, polymorphic: true

  validates_presence_of :liable, :uid
end
