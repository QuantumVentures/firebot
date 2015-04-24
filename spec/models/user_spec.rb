require "rails_helper"

describe User do
  subject { build :user }

  it { should be_valid }

  it_should_behave_like :crud
  it_should_behave_like :restoreable

  it { should have_many(:access_tokens).dependent :destroy }
  it { should have_many(:backend_apps).dependent :destroy }
  it { should have_many(:logs).dependent :destroy }
  it { should have_many(:payment_methods).dependent :destroy }

  it { should allow_value("email@addresse.foo").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it do
    should validate_uniqueness_of(:email).scoped_to(:deleted_at)
                                         .case_insensitive
  end

  it { should respond_to :apps }

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

  describe "#first_name_capitalized" do
    it "should capitalize the first letter of the first name" do
      expect(subject.first_name_capitalized).to eq subject.first_name.capitalize
    end
  end
end
