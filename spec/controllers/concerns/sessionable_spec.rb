require "rails_helper"

describe Sessionable, type: :controller do
  described_class.tap do |mod|
    controller ApplicationController do
      include mod
    end
  end

  let(:user) { create :user }

  describe "#log_in" do
    before { controller.log_in user }

    it "should set the session :user_id" do
      expect(session[:user_id]).to eq user.id
    end
  end

  describe "#log_out" do
    before do
      controller.log_in user
      controller.log_out
    end

    it "should delete the session :user_id" do
      expect(session[:user_id]).to be_nil
    end

    it "should set @current_user to nil" do
      expect(controller.current_user).to be_nil
    end
  end

  describe "#logged_in?" do
    context "when logged in" do
      it "should be true" do
        controller.log_in user
        expect(controller.logged_in?).to be true
      end
    end

    context "when logged out" do
      it "should be false" do
        expect(controller.logged_in?).to be false
      end
    end
  end

  describe "#require_login" do
    context "when logged in" do
      before { controller.log_in user }

      it "should not receive :redirect_to" do
        expect(controller).not_to receive :redirect_to
        controller.require_login
      end
    end

    context "when logged out" do
      it "should receive :redirect_to" do
        expect(controller).to receive(:redirect_to).with new_user_path
        controller.require_login
      end
    end
  end

  describe "#require_logout" do
    context "when logged in" do
      before { controller.log_in user }

      it "should receive :redirect_to" do
        expect(controller).to receive(:redirect_to).with root_path
        controller.require_logout
      end
    end

    context "when logged out" do
      it "should not receive :redirect_to" do
        expect(controller).not_to receive :redirect_to
        controller.require_logout
      end
    end
  end
end
