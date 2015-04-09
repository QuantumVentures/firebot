require "rails_helper"

describe Model do
  subject { build :model }

  it_should_behave_like :crud
  it_should_behave_like :restoreable

  it { should belong_to :backend_app }

  it { should validate_presence_of :backend_app }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:backend_app_id).scoped_to :name }

  describe "validate column_types" do
    let(:column_type) { "string" }

    before { subject.schema["name"] = column_type }

    context "with valid column type" do
      it "should be valid" do
        expect(subject.valid?).to be true
      end
    end

    context "with invalid column type" do
      let(:column_type) { "foo" }

      it "should not be valid" do
        expect(subject.valid?).to be false
      end
    end
  end

  describe ".before_save" do
    before { subject.save }

    it "should set created_at, id, and updated_at in the schema" do
      expect(subject.schema["created_at"]).to eq "date"
      expect(subject.schema["id"]).to eq "string"
      expect(subject.schema["updated_at"]).to eq "date"
    end
  end
end
