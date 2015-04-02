class User < ActiveRecord::Base
  acts_as_paranoid

  attr_accessor :full_name, :password

  validate :validate_password_create, on: :create
  validate :validate_password_update, on: :update
  validates_format_of :email, with: /.+@..+/i
  validates_presence_of :email, :first_name, :last_name
  validates_uniqueness_of :email

  has_secure_password validations: false

  before_validation :parse_full_name, on: :create

  private

  def parse_full_name
    if full_name.present?
      names           = full_name.split(" ")
      self.first_name = names.slice(0, names.size - 1)
      self.last_name  = names[-1] if names.size > 1
    end
  end

  def validate_password_create
    if password.nil? || password.length < 2
      errors.add :password, "must be at least 2 characters"
    end
  end

  def validate_password_update
    if password.present? && password.length < 2
      errors.add :password, "must be at least 2 characters"
    end
  end
end
