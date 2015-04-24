require "rails_helper"

describe Composition do
  it_should_behave_like :crud

  it { should belong_to :component }
  it { should belong_to :composable }

  it { should validate_presence_of :component }
  it { should validate_presence_of :composable }

  subject { build :composition }

  describe "validates_uniqueness_of component_id" do
    it "should be valid" do
      expect(subject.valid?).to be true
    end

    context "when composable_id and composable_type exists" do
      it "should not be valid" do
        composition = create :composition, component: subject.component,
                                           composable: subject.composable
        expect(subject.valid?).to be false
      end
    end

    context "when composable_id is same and composable_type is different" do
      it "should be valid" do
        composition = create :composition, component:  subject.component,
                                           composable: create(:backend_app)
        composition.update composable_id: subject.composable.id
        expect(subject.valid?).to be true
      end
    end
  end
end
