require "rails_helper"

describe FeaturesController do
  let(:backend_app) { create :backend_app, user: user }
  let(:user)        { create :user }

  before { controller.log_in user }

  describe "POST create" do
    let(:backend_app_id) { backend_app.id }
    let(:descriptions)   { "1. 2. 3." }

    before do
      post :create, backend_app_id: backend_app_id, descriptions: descriptions
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

  describe "GET new" do
    let(:backend_app_id) { backend_app.id }

    before { get :new, backend_app_id: backend_app_id }

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
end
