require "rails_helper"

describe PageTitleHelper do
  describe "#page_title" do
    let(:page_title) { "page_title" }

    before { view.content_for :page_title, page_title }

    context "when content_for :page_title exists" do
      it "should return the page title" do
        expect(helper.page_title).to eq page_title
      end
    end

    context "when content_for :page_title does not exists" do
      let(:page_title) { nil }

      it "should return the default page title" do
        expect(helper.page_title).to eq "Firebot"
      end
    end
  end
end
