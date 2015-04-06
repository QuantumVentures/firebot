require "rails_helper"

describe BackendApp do
  subject { build :backend_app }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should be_valid }

  it_should_behave_like :crud

  it { should have_many :logs }

  it { should belong_to :user }

  describe "#features" do
    let(:backend_app) { create :backend_app }
    let(:feature)     { create :feature, loggable: backend_app }

    it "should include the feature" do
      expect(backend_app.features).to include feature
    end
  end
end
