require "rails_helper"

describe ModelsController do
  let(:backend_app) { create :backend_app }
  let(:model)       { create :model, backend_app: backend_app }

  before { controller.log_in backend_app.user }

  describe "POST create" do
    let(:name) { "name" }

    subject do
      post :create, backend_app_id: backend_app.id, model: { name: name }
    end

    context "with valid attributes" do
      it "should create a model" do
        expect{subject}.to change{Model.count}.by 1
      end

      it "should redirect to backend_app_models_path" do
        expect(subject).to redirect_to backend_app_models_path(backend_app)
      end
    end

    context "with invalid attributes" do
      let(:name) { nil }

      it "should not create a model" do
        expect{subject}.to change{Model.count}.by 0
      end
    end
  end

  describe "DELETE destroy" do
    subject { delete :destroy, backend_app_id: backend_app.id, id: model.id }

    it "should destroy a model" do
      subject
      expect(Model.count).to eq 0
    end

    it "should redirect_to backend_app_models_path" do
      expect(subject).to redirect_to backend_app_models_path(backend_app)
    end
  end

  describe "GET edit" do
    let(:model_id) { model.id }

    before { get :edit, backend_app_id: backend_app.id, id: model_id }

    context "when model exists" do
      it { should respond_with :success }
    end

    context "when model does not exist" do
      let(:model_id) { 0 }

      it "should redirect_to backend_app_models_path" do
        expect(controller).to redirect_to backend_app_models_path(backend_app)
      end

      it "should have a flash error" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET index" do
    before { get :index, backend_app_id: backend_app.id }

    it { should respond_with :success }
  end

  describe "GET new" do
    before { get :new, backend_app_id: backend_app.id }

    it { should respond_with :success }
  end

  describe "POST remove_column" do
    let(:column) { "name" }

    subject do
      model.add_column column, type: "string"
      model.save
      post :remove_column, backend_app_id: backend_app.id, id: model.id,
                           name: column
    end

    it "should remove the column" do
      subject
      model.reload
      expect(model.schema[column]).to be_nil
    end

    it "should redirect_to edit_backend_app_model_path" do
      expect(subject).to redirect_to edit_backend_app_model_path(
        backend_app, model
      )
    end
  end

  describe "PATCH update" do
    let(:name) { "new name".capitalize }

    subject do
      patch :update, backend_app_id: backend_app.id, id: model.id,
                     model: { name: name }, name: "age", type: "number"
    end

    context "with valid attributes" do
      it "should update the model" do
        subject
        model.reload
        expect(model.name).to eq name
      end

      it "should redirect_to edit_backend_app_model_path" do
        expect(subject).to redirect_to edit_backend_app_model_path(
          backend_app, model
        )
      end

      it "should add a column to the shema" do
        subject
        model.reload
        expect(model.schema["age"]["type"]).to eq "number"
      end
    end

    context "with invalid attributes" do
      let(:name) { nil }

      it "should not update the model" do
        subject
        model.reload
        expect(model.name).not_to eq name
      end

      it "should render edit" do
        expect(subject).to render_template "edit"
      end
    end
  end
end
