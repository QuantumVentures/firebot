require "rails_helper"

describe ModelsController do
  let(:backend_app) { create :backend_app }

  before { controller.log_in backend_app.user }

  describe "POST create" do
    context "with valid attributes" do

    end

    context "with invalid attributes" do
    end
  end

  describe "GET new" do
    before { get :new, backend_app_id: backend_app.id }

    it { should respond_with :success }
  end
end
