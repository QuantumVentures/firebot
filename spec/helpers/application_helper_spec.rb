require "rails_helper"

describe ApplicationHelper do

  describe "#body_attributes" do
    it "should have a hash with class" do
      expect(helper.body_attributes).to have_key :class
    end
  end

  describe "#mobile_meta_content" do
    it "should have the write text" do
      expect(helper.mobile_meta_content).to eq(
        "initial-scale=1.0, maximum-scale=1.0, user-scalable=0, width=320"
      )
    end
  end

  describe "#title" do
    it "should equal Firebot when @title is nil" do
      expect(helper.title).to eq "Firebot"
    end
  end
end
