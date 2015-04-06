module ApplicationModel
  extend ActiveSupport::Concern

  included do
    include Inheritable

    class << self
      alias_method :restoreable, :acts_as_paranoid
    end
  end
end
