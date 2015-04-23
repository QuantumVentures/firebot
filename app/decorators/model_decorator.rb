class ModelDecorator < Draper::Decorator
  delegate_all

  def description
    if object.description.present?
      object.description
    else
      "no description available"
    end
  end
end
