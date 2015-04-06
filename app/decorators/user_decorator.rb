class UserDecorator < Draper::Decorator
  delegate_all

  def first_name
    object.first_name.capitalize
  end
end
