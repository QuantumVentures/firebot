class User < ActiveRecord::Base
  include ApplicationModel

  restoreable

  attr_accessor :full_name

  validate :validate_password_create, on: :create
  validate :validate_password_update, on: :update
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates_presence_of :first_name, :last_name

  with_options dependent: :destroy do
    has_many :access_tokens
    has_many :backend_apps
    has_many :logs,            as: :responsible
    has_many :payment_methods, as: :liable
  end

  has_secure_password validations: false

  before_save { self.email = email.downcase }
  before_validation :parse_full_name, on: :create

  alias_method :apps, :backend_apps

  def first_name_capitalized
    first_name.capitalize
  end

  private

  def parse_full_name
    if full_name.present?
      names           = full_name.split(" ")
      self.first_name = names.slice(0, names.size - 1).join(" ")
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
