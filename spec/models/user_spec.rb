require "rails_helper"

describe User do
  subject { build :user }

  it { should allow_value("email@addresse.foo").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_uniqueness_of :email }

  it { should be_valid }

  it_should_behave_like :crud
end
