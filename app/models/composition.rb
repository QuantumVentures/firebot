class Composition < ActiveRecord::Base
  include ApplicationModel

  belongs_to :component
  belongs_to :composable, polymorphic: true
end
