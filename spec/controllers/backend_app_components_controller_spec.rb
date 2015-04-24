require "rails_helper"

describe BackendAppComponentsController do
  let(:component) { create :component }

  include_context :logged_in

  describe "POST create" do
    before do
      post :create, backend_app_id: backend_app.id, component_id: component.id
    end

    it "should add the component" do
      expect(backend_app.components).to include component
    end

    it "should flash success" do
      expect(flash[:success]).not_to be_nil
    end

    it "should redirect_to backend_app_components_path" do
      expect(controller).to redirect_to backend_app_components_path(backend_app)
    end
  end

  describe "DELETE destroy" do
    before do
      backend_app.add_component component
      delete :destroy, backend_app_id: backend_app.id, id: component.id
    end

    it "should remove the component" do
      expect(backend_app.components).not_to include component
    end

    it "should flash notice" do
      expect(flash[:notice]).not_to be_nil
    end

    it "should redirect_to backend_app_components_path" do
      expect(controller).to redirect_to backend_app_components_path(backend_app)
    end
  end

  %i(index new).each do |action|
    describe "GET #{action.to_s}" do
      before { get action, backend_app_id: backend_app.id }

      it { should respond_with :success }
    end
  end

  describe "GET show" do
    let(:component_id) { component.id }

    before do
      backend_app.add_component component
      get :show, backend_app_id: backend_app.id, id: component_id
    end

    it { should respond_with :success }

    context "when component doesn't exist" do
      let(:component_id) { 0 }

      it "should flash notice" do
        expect(flash[:notice]).not_to be_nil
      end

      it "should redirect_to backend_app_components_path" do
        expect(controller).to redirect_to backend_app_components_path(
          backend_app
        )
      end
    end
  end
end
