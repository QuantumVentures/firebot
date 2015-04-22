class Component < ActiveRecord::Base
  include ApplicationModel

  has_many :compositions, dependent: :destroy
  has_many :components, source: :composable, source_type: "Component",
                        through: :compositions

  has_many :inverse_compositions, class_name: "Composition",
                                  foreign_key: :composable_id,
                                  dependent: :destroy
  has_many :parents, source: :component, through: :inverse_compositions

  validate :column_types
  validates_presence_of :name
  validates_uniqueness_of :name

  before_validation :set_default_json

  def add_model(model)
    self.models[model.name] = model.schema
  end

  private

  def column_types
    models.each do |name, schema|
      diff = schema.values.map { |h| h["type"] }.uniq - Model::COLUMN_TYPES
      if diff.size > 0
        types = diff.join ", "
        errors.add :models, "invalid column type(s) #{types} in model #{name}"
      end
    end
  end

  def set_default_json
    self.models = {} if models.nil?
  end
end
