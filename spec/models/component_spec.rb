require "rails_helper"

describe Component do
  it_should_behave_like :crud

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  subject { build :component }

  describe "#validate :column_types" do
    let(:type) { "string" }

    before { subject.models["User"] = { "name" => { "type" => type } } }

    context "when column type is valid" do
      it "should return true" do
        expect(subject.valid?).to be true
      end
    end

    context "when column type is invalid" do
      let(:type) { "foo" }

      it "should return false" do
        expect(subject.valid?).to be false
      end
    end
  end

  describe "#add_model" do
    let(:model) { create :model }

    it "should add a key and value pair to the models" do
      subject.add_model model
      expect(subject.models[model.name]).to eq model.schema
    end
  end
end
