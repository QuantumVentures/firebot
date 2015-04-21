require "rails_helper"

describe Component do
  it_should_behave_like :crud

  it { should have_many(:models).dependent :destroy }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
