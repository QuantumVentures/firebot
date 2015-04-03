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

  describe "#log_in" do
    before { helper.log_in user }

    it "should set the session :user_id" do
      expect(session[:user_id]).to eq user.id
    end
  end

  describe "#log_out" do
    before do
      helper.log_in user
      helper.log_out
    end

    it "should delete the session :user_id" do
      expect(session[:user_id]).to be_nil
    end

    it "should set @current_user to nil" do
      expect(helper.current_user).to be_nil
    end
  end

  describe "#logged_in?" do
    context "when logged in" do
      it "should be true" do
        helper.log_in user
        expect(helper.logged_in?).to be true
      end
    end

    context "when logged out" do
      it "should be false" do
        expect(helper.logged_in?).to be false
      end
    end
  end
end
