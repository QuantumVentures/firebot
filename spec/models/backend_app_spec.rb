require "rails_helper"

describe BackendApp do
  subject { build :backend_app }

  it_should_behave_like :crud

  it { should have_many(:access_tokens).dependent :destroy }
  it { should have_many(:components).through :compositions }
  it do
    should have_many(:compositions).with_foreign_key(:composable_id)
                                   .dependent :destroy
  end
  it { should have_many(:features).dependent :destroy }
  it { should have_many(:logs).dependent :destroy }
  it { should have_many(:models).dependent :destroy }

  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should be_valid }

  describe ".before_create" do
    before { subject.save }

    it "should set the uid" do
      expect(subject.uid).not_to be_nil
    end
  end
end
