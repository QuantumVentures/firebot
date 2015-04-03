class ApplicationController < ActionController::Base
  include Sessionable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def stringify_single_error(errors)
    error = errors.first
    error[0].to_s.split("_").join(" ").capitalize + " #{error[1]}"
  end
end
