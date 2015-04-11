require "rails_helper"

describe AccessToken do
  subject { build :access_token }

  describe ".before_create" do
    let(:access_token) { create :access_token, tokenable: backend_app }
    let(:backend_app)  { create :backend_app }

    before { access_token.save }

    describe "#set_tokenable_uid" do
      it "should set the tokenable_uid" do
        expect(access_token.tokenable_uid).to eq backend_app.uid
      end
    end
  end

  describe "#lifespan" do
    it "should have a lifespan of 12 months" do
      expect(subject.lifespan).to eq 12.months
    end
  end
end
