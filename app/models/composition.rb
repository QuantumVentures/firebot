class Composition < ActiveRecord::Base
  include ApplicationModel

  belongs_to :component
  belongs_to :composable, polymorphic: true

  validate :composed_of_same_component
  validates_uniqueness_of :component_id,
                          scope: %i(composable_id composable_type)

  private

  def composed_of_same_component
    if composable_type == "Component" && component_id == composable_id
      errors.add :composable, "cannot be the same component"
    end
  end
end
