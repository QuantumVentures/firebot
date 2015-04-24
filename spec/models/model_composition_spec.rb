require "rails_helper"

describe ModelComposition do
  it_should_behave_like :crud

  it { should belong_to :composition }
  it { should belong_to :model }
end
