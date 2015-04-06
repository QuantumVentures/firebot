require "rails_helper"

describe PaymentMethod do
  it_should_behave_like :crud

  subject { build :payment_method }

  it { should validate_presence_of :liable }
  it { should validate_presence_of :uid }

  it { should be_valid }

  it { should belong_to :liable }
end
