require "rails_helper"

describe SessionsController do
  let(:password) { "password" }
  let(:user)     { create :user, password: "password" }

  describe "POST #create" do
    context "with correct password" do
      subject { post :create, email: user.email, password: password }

      it "should log_in user" do
        expect(controller).to receive :log_in
        subject
      end

      it "should redirect to backend_apps_path" do
        expect(subject).to redirect_to backend_apps_path
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
    subject { get :logout }

    before { controller.log_in user }

    it "should log_out user" do
      expect(controller).to receive :log_out
      subject
    end

    it "should redirect to root_path" do
        expect(subject).to redirect_to root_path
      end
  end
end
