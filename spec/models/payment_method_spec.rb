require "rails_helper"

describe PaymentMethod do
  subject { build :payment_method }

  it_should_behave_like :crud

  it { should validate_presence_of :liable }
  it { should validate_presence_of :uid }

  it { should be_valid }

  it { should belong_to :liable }
end
