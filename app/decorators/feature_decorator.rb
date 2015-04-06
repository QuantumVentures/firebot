class FeatureDecorator < Draper::Decorator
  delegate_all

  def completed_at
    object.completed_at.strftime time_format
  end

  def created_at
    object.created_at.strftime time_format
  end

  private

  def time_format
    "%b %d, %y at %I:%M %P"
  end
end
