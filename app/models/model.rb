class Model < ActiveRecord::Base
  include ApplicationModel

  restoreable

  belongs_to :backend_app

  validate :column_types
  validates_presence_of :backend_app, :name
  validates_uniqueness_of :name, scope: :backend_app, case_sensitive: false

  before_validation :set_default_json
  before_save :capitalize_name
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

  def add_column(key, options)
    type = options[:type].to_s
    if COLUMN_TYPES.index type
      self.schema[key.to_s.split(" ").join("_").downcase] = {
        "relationship_to" => options[:relationship_to] || nil,
        "required"        => options[:required] || false,
        "type"            => type
      }
    end
  end

  private

  def capitalize_name
    self.name = name.try :capitalize
  end

  def column_types
    diff = schema_column_types - COLUMN_TYPES
    if diff.size > 0
      types = diff.join ", "
      errors.add :schema, "invalid column type(s) #{types}"
    end
  end

  def schema_column_types
    schema.values.map { |h| h["type"] }.uniq
  end

  def set_default_json
    self.schema = {} if schema.nil?
  end

  def set_default_schema
    set_created_at_schema unless schema["created_at"]
    set_id_schema unless schema["id"]
    set_updated_at_schema unless schema["updated_at"]
  end

  def set_created_at_schema
    add_column :created_at, required: false, type: "date"
  end

  def set_id_schema
    add_column :id, required: false, type: "string"
  end

  def set_updated_at_schema
    add_column :updated_at, required: false, type: "date"
  end
end
