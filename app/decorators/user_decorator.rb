class UserDecorator < Draper::Decorator
  def first_name
    object.first_name.capitalize
  end
end
