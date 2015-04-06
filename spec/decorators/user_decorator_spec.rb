require "rails_helper"

describe UserDecorator do
  let(:user) { create :user }

  subject { user.decorate }

  describe "#first_name" do
    it "should have the first letter capitalized" do
      expect(subject.first_name).to eq user.first_name.capitalize
    end
  end
end
