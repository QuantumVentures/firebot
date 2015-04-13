class Model < ActiveRecord::Base
  include ApplicationModel

  restoreable

  belongs_to :backend_app

  validate :column_types
  validates_presence_of :backend_app, :name
  validates_uniqueness_of :name, scope: :backend_app, case_sensitive: false

  before_validation :default_schema
  before_save :set_default_schema

  COLUMN_TYPES = %w(
    array
    boolean
    coordinate
    date
    file
    number
    object
    pointer
    relation
    string
  ).freeze

  def update_schema(key, options)
    if COLUMN_TYPES.index options[:type].to_s
      self.schema[key.to_s] = {
        "relationship_to" => options[:relationship_to],
        "required"        => options[:required],
        "type"            => options[:type]
      }
      true
    else
      false
    end
  end

  private

  def column_types
    if (schema_column_types - COLUMN_TYPES).size > 0
      errors.add :schema, "invalid column type"
    end
  end

  def default_schema
    self.schema = {} if schema.nil?
  end

  def schema_column_types
    schema.values.map { |h| h["type"] }.uniq
  end

  def set_default_schema
    set_created_at_schema unless schema["created_at"]
    set_id_schema unless schema["id"]
    set_updated_at_schema unless schema["updated_at"]
  end

  def set_created_at_schema
    update_schema :created_at, required: false, type: "date"
  end

  def set_id_schema
    update_schema :id, required: false, type: "string"
  end

  def set_updated_at_schema
    update_schema :updated_at, required: false, type: "date"
  end
end
