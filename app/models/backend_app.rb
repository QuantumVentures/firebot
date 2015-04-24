class BackendApp < ActiveRecord::Base
  include ApplicationModel

  restoreable

  with_options dependent: :destroy do
    has_many :access_tokens, as: :tokenable
    has_many :compositions, -> { where composable_type: "BackendApp" },
                            foreign_key: :composable_id
    has_many :features, as: :loggable
    has_many :logs, as: :loggable
    has_many :models
  end

  has_many :components, through: :compositions

  belongs_to :user

  validates_presence_of :name, :user
  validates_uniqueness_of :name, scope: :user_id

  before_create :set_uid

  # def add_component(component)
  #   composition = Composition.new component: component, composable: self
  #   add_models_from_component(component) if composition.save
  # end

  # def add_models_from_component(component)
  #   component.models.each do |name, schema|
  #     model = models.new name: name, schema: schema
  #     if model.save

  #     end
  #   end
  # end

  # def remove_component(component)
  #   composition = compositions.find_by(component_id: component.id)
  #   remove_models_from_component(component) if composition.destroy
  # end

  # def remove_models_from_component(component)

  # end

  private

  def set_uid
    self.uid = SecureRandom.uuid.split("-").join ""
  end
end
