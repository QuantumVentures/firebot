require "rails_helper"

describe BackendApp do
  let(:backend_app) { create :backend_app }
  let(:component)   { create :component }
  let(:model)       { create :model }

  subject { build :backend_app }

  it_should_behave_like :crud

  it { should have_many(:access_tokens).dependent :destroy }
  it { should have_many(:components).through :compositions }
  it do
    should have_many(:compositions).with_foreign_key(:composable_id)
                                   .dependent :destroy
  end
  it { should have_many(:features).dependent :destroy }
  it { should have_many(:logs).dependent :destroy }
  it { should have_many(:models).dependent :destroy }

  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user }
  it { should validate_uniqueness_of(:name).scoped_to :user_id }

  it { should be_valid }

  describe ".before_create" do
    before { subject.save }

    it "should set the uid" do
      expect(subject.uid).not_to be_nil
    end
  end

  describe "#add_component" do
    let(:component2) { create :component }
    let(:model2)     { create :model }
    let(:model3)     { create :model }

    before do
      component.add_model model
      component.save
      component2.add_model model2
      component2.save
      component.add_component component2
      backend_app.add_component component
    end

    context "when component has not been added to the app" do
      it "should change the size of the app's components" do
        expect(backend_app.components).to include component
      end

      it "should create models for the app from all the components" do
        expect(backend_app.models.find_by(name: model.name)).not_to be_nil
        expect(backend_app.models.find_by(name: model2.name)).not_to be_nil
      end

      it "should connect the model with the composition" do
        comp = backend_app.compositions.find_by component_id: component.id
        expect(comp.models).to include(
          backend_app.models.find_by name: model.name
        )
      end
    end

    context "when component has already been added to the app" do
      before do
        component.add_model model3
        component.save
        backend_app.add_component component
      end

      it "should not change the size of the apps' components" do
        expect(backend_app.components.size).to eq 1
      end

      it "should not create models for the app" do
        expect(backend_app.models.find_by(name: model3.name)).to be_nil
      end
    end
  end

  describe "#remove_component" do
    let(:action) { backend_app.remove_component component }
    let(:composition) do
      backend_app.compositions.find_by component_id: component.id
    end

    before do
      component.add_model model
      component.save
      backend_app.add_component component
    end

    it "should destroy all models connected to the composition" do
      expect{action}.to change{backend_app.models.size}.by -1
    end

    it "should destroy the composition" do
      expect{action}.to change backend_app.compositions, :size
    end
  end
end
