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

  it { should have_many :backend_apps }
  it { should have_many :logs }

  context "when updating" do
    let(:password) { "password" }
    let(:user)     { create :user }

    before { user.assign_attributes password: password }

    context "with valid password" do
      it "should be valid" do
        expect(user.valid?).to be true
      end
    end

    context "with invalid password" do
      let(:password) { "1" }

      it "should not be valid" do
        expect(user.valid?).to be false
      end
    end
  end
end