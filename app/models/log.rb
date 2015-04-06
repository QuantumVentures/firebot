class Log < ActiveRecord::Base
  include Inheritable

  acts_as_paranoid
  inheritable

  validates_presence_of :description, :loggable

  belongs_to :loggable,    polymorphic: true
  belongs_to :responsible, polymorphic: true

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
