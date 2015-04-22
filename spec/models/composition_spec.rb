require "rails_helper"

describe Composition do
  it_should_behave_like :crud

  it { should belong_to :component }
  it { should belong_to :composable }
end
