require "rails_helper"

describe SessionsHelper do
  let(:user) { create :user }

  describe "#current_user" do
    context "when logged in" do
      before { session[:user_id] = user.id }

      it "should equal user" do
        expect(helper.current_user).to eq user
      end
    end

    context "when not logged in" do
      it "should be nil" do
        expect(helper.current_user).to be_nil
      end
    end
  end

  describe "#logged_in?" do
    context "when current_user not nil" do
      before { session[:user_id] = user.id }

      it "should be true" do
        expect(helper.logged_in?).to be true
      end
    end

    context "when current_user nil" do
      it "should be false" do
        expect(helper.logged_in?).to be false
      end
    end
  end
end
