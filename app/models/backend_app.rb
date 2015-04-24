class BackendApp < ActiveRecord::Base
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

  def add_component(component)
    composition = Composition.new component: component, composable: self
    add_models_from_component(component, composition) if composition.save
  end

  def remove_component(component)
    composition = compositions.find_by component_id: component.id
    composition.models.each do |model|
      model.destroy
    end
    composition.destroy
  end

  private

  def add_models_from_component(component, composition)
    add_model_from_components component.components, composition
    component.models.each do |name, schema|
      model = models.new name: name, schema: schema
      model.model_compositions.create(composition: composition) if model.save
    end
  end

  def add_model_from_components(components, composition)
    components.each do |component|
      add_models_from_component component, composition
    end
  end

  def set_uid
    self.uid = SecureRandom.uuid.split("-").join ""
  end
end
