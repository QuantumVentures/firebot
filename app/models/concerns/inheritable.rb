module Inheritable
  extend ActiveSupport::Concern

  module ClassMethods
    def inheritable
      before_create { self.type = self.class.name }
    end
  end
end
