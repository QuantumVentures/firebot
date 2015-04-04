require "rails_helper"

describe BackendAppsController do
  let(:backend_app) { create :backend_app, user: user }
  let(:user)        { create :user }

  before { controller.log_in user }

  describe "POST create" do
    let(:action) { post :create, backend_app: params }
    let(:params) { attributes_for :backend_app }

    context "with correct params" do
      it "should create a backend_app" do
        expect{action}.to change{BackendApp.count}.by 1
      end
    end

    context "with incorrect params" do
      let(:params) { { name: nil } }

      it "should not create a backend_app" do
        expect{action}.to change{BackendApp.count}.by 0
      end

      it "should have errors" do
        action
        expect(assigns :errors).not_to be_nil
      end
    end
  end

  describe "GET describe" do
    let(:backend_app_id) { backend_app.id }

    before { get :describe, id: backend_app_id }

    context "when app is found" do
      it { should respond_with :success }
    end

    context "when app is not found" do
      let(:backend_app_id) { 0 }

      it "should redirect to new_backend_app_path" do
        expect(controller).to redirect_to new_backend_app_path
      end
    end
  end

  describe "GET new" do
    before { get :new }

    it { should respond_with :success }
  end
end
