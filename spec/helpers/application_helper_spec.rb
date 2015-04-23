require "rails_helper"

describe ApplicationHelper do
  describe "#mobile_meta_content" do
    it "should have the write text" do
      expect(helper.mobile_meta_content).to eq(
        "initial-scale=1.0, maximum-scale=1.0, user-scalable=0, width=320"
      )
    end
  end

  describe "#user_background_image" do
    it "should return a string" do
      user = create :user
      expect(helper.user_background_image user).to include "background-image"
    end
  end
end
