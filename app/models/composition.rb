class Composition < ActiveRecord::Base
  include ApplicationModel

  belongs_to :component
  belongs_to :composable, polymorphic: true

  validates_presence_of :component, :composable
  validates_uniqueness_of :component_id,
                          scope: %i(composable_id composable_type)
end
