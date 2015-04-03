class Log < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :description, :loggable, :responsible

  belongs_to :loggable,    polymorphic: true
  belongs_to :responsible, polymorphic: true
end
