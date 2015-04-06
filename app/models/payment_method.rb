class PaymentMethod < ActiveRecord::Base
  include ApplicationModel

  inheritable
  restoreable

  validates_presence_of :liable, :uid

  belongs_to :liable, polymorphic: true
end
