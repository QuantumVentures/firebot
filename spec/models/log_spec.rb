require "rails_helper"

describe Log do
  subject { build :log }

  it { should validate_presence_of :description }
  it { should validate_presence_of :loggable }
  it { should validate_presence_of :responsible }

  it { should be_valid }

  it_should_behave_like :crud

  it { should belong_to :loggable }
  it { should belong_to :responsible }
end
