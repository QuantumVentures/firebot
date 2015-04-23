require "rails_helper"

describe UsersController do
  describe "POST create" do
    let(:params) { attributes_for(:user).merge({ full_name: "f l" }) }

    subject { post :create, user: params }

    context "with correct params" do
      it "should create a user" do
        expect{subject}.to change{User.count}.by 1
      end

      it "should log_in user" do
        expect(controller).to receive :log_in
        subject
      end

      it "should redirect to new_backend_app_path" do
        expect(subject).to redirect_to new_backend_app_path
      end
    end

    context "with incorrect params" do
      let(:params) { { full_name: "t l" } }

      it "should not create a user" do
        expect{subject}.to change{User.count}.by 0
      end

      it "should have errors" do
        subject
        expect(assigns :errors).not_to be_nil
      end
    end
  end

  describe "GET new" do
    before { get :new }

    it { should respond_with :success }
  end
end
