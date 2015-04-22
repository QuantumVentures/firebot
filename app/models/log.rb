class Log < ActiveRecord::Base
  include ApplicationModel

  inheritable
  restoreable

  belongs_to :loggable,    polymorphic: true
  belongs_to :responsible, polymorphic: true

  validates_presence_of :description, :loggable

  class << self
    def completed
      where.not completed_at: nil
    end

    def incompleted
      where completed_at: nil
    end
  end

  def completed?
    !completed_at.nil?
  end
end
