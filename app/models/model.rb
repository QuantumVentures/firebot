class Model < ActiveRecord::Base
  include ApplicationModel

  restoreable

  belongs_to :backend_app

  validate :column_types
  validates_presence_of :backend_app, :name
  validates_uniqueness_of :name, scope: :backend_app, case_sensitive: false

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

  private

  def column_types
    if (schema.values.uniq - COLUMN_TYPES).size > 0
      errors.add :schema, "invalid column type"
    end
  end

  def set_default_schema
    self.schema["created_at"] = "date" unless schema["created_at"]
    self.schema["id"]         = "string" unless schema["id"]
    self.schema["updated_at"] = "date" unless schema["updated_at"]
  end
end
