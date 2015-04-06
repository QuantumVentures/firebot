require "rails_helper"

describe BackendApp do
  subject { build :backend_app }

  it_should_behave_like :crud

  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should be_valid }

  it { should have_many :logs }

  it { should belong_to :user }
end
