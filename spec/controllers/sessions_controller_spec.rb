require "rails_helper"

describe SessionsController do
  let(:password) { "password" }
  let(:user)     { create :user, password: "password" }

  describe "POST #create" do
    context "with correct password" do
      it "should log_in user" do
        expect(controller).to receive :log_in
        post :create, email: user.email, password: password
      end
    end

    context "with incorrect password" do
      let(:password) { "" }

      it "should have errors" do
        post :create, email: user.email, password: password
        expect(assigns :errors).not_to be_nil
      end
    end
  end

  describe "GET #login" do
    before { get :login }

    it { should respond_with :success }
  end

  describe "GET #logout" do
    before { controller.log_in user }

    it "should log_out user" do
      expect(controller).to receive :log_out
      get :logout
    end
  end
end
