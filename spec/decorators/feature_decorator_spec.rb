require "rails_helper"

describe FeatureDecorator do
  let(:feature) { create :feature, completed_at: Time.zone.now }

  subject { feature.decorate }

  describe "#completed_at" do
    it "should equal the correct format" do
      expect(subject.completed_at).to eq feature.completed_at.strftime(
        "%b %d, %y at %I:%M %P"
      )
    end
  end

  describe "#created_at" do
    it "should equal the correct format" do
      expect(subject.created_at).to eq feature.created_at.strftime(
        "%b %d, %y at %I:%M %P"
      )
    end
  end
end
