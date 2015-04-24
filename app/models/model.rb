class Model < ActiveRecord::Base
  include ApplicationModel

  restoreable

  belongs_to :backend_app

  validate :column_types
  validates_format_of :name, with: /\A[A-Za-z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*\z/
  validates_presence_of :backend_app, :name
  validates_uniqueness_of :name, scope: :backend_app, case_sensitive: false

  before_validation :set_default_json
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

  def add_column(name, options)
    column = formatted_column_name name
    if column_exists? column
      update_column column, options
    else
      add_new_column column, options
    end
  end

  def remove_column(name)
    self.schema.delete name
  end

  private

  def add_new_column(column, options)
    self.schema[column] = {
      "created_at"      => Time.zone.now,
      "relationship_to" => default_relationship_to(options[:relationship_to]),
      "required"        => default_required(options[:required]),
      "type"            => options[:type].to_s,
      "updated_at"      => Time.zone.now
    }
  end

  def column_exists?(name)
    schema[name].present?
  end

  def column_types
    diff = schema_column_types - COLUMN_TYPES
    if diff.size > 0
      types = diff.join ", "
      errors.add :schema, "invalid column type(s) #{types}"
    end
  end

  def default_relationship_to(relationship_to)
    relationship_to.present? ? relationship_to.capitalize : nil
  end

  def default_required(required)
    required.present? && required ? true : false
  end

  def formatted_column_name(name)
    name.to_s.split(" ").join("_").downcase
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

  def update_column(column, options)
    if options[:relationship_to]
      update_column_relationship_to column, options[:relationship_to]
    end
    if options[:required]
      update_column_required column, options[:required]
    end
    if options[:type]
      update_column_type column, options[:type].to_s
    end
  end

  def update_column_relationship_to(column, value)
    self.schema[column]["relationship_to"] = value
  end

  def update_column_required(column, value)
    self.schema[column]["required"] = value
  end

  def update_column_type(column, value)
    self.schema[column]["type"] = value
  end
end
