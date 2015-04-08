require "rails_helper"

describe BackendApp do
  subject { build :backend_app }

  it_should_behave_like :crud

  it { should have_many :access_tokens }
  it { should have_many :features }
  it { should have_many :logs }

  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should be_valid }
end
