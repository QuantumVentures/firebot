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

      it "should redirect_to descriptions_backend_app_path" do
        action
        expect(controller).to redirect_to(
          descriptions_backend_app_path user.apps.first
        )
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

  describe "POST describe" do
    let(:backend_app_id) { backend_app.id }
    let(:descriptions)   { "1. 2. 3." }

    before do
      controller.log_in backend_app.user
      post :describe, id: backend_app_id, descriptions: descriptions
    end

    context "with descriptions" do
      it "should create 3 descriptions" do
        expect(backend_app.logs.size).to eq 3
      end

      it "should redirect_to status_backend_app_path" do
        expect(controller).to redirect_to(
          status_backend_app_path backend_app
        )
      end
    end

    context "without descriptions" do
      let(:descriptions) { nil }

      it "should have errors" do
        expect(assigns :errors).not_to be_nil
      end
    end

    context "with the wrong backend_app_id" do
      let(:backend_app_id) { 0 }

      it "should redirect" do
        expect(controller).to redirect_to new_backend_app_path
      end
    end
  end

  describe "GET descriptions" do
    let(:backend_app_id) { backend_app.id }

    before { get :descriptions, id: backend_app_id }

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

  describe "GET status" do
    before { get :status, id: backend_app.id }

    it { should respond_with :success }
  end
end
