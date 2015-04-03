require "rails_helper"

describe BackendAppsController do
  let(:user) { create :user }

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

  describe "GET new" do
    before { get :new }

    it { should respond_with :success }
  end
end
