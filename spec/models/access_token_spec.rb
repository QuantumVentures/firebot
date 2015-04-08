require "rails_helper"

describe AccessToken do
  subject { build :access_token }

  describe "#lifespan" do
    it "should have a lifespan of 12 months" do
      expect(subject.lifespan).to eq 12.months
    end
  end
end
