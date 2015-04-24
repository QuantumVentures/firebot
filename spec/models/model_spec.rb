require "rails_helper"

describe Model do
  subject { build :model }

  it_should_behave_like :crud

  it { should have_many(:compositions).through :model_compositions }
  it { should have_many(:model_compositions).dependent :destroy }

  it { should belong_to :backend_app }

  it { should validate_presence_of :backend_app }
  it { should validate_presence_of :name }
  it do
    should validate_uniqueness_of(:name).scoped_to(:backend_app_id)
                                        .case_insensitive
  end

  describe "validate :column_types" do
    let(:column_type) { "string" }

    before { subject.schema["name"] = { "type" => column_type } }

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

  describe "validate format of name" do
    context "when name contains only letters, numbers, and underscores" do
      it "should be valid" do
        subject.name = "name"
        expect(subject.valid?).to be true
      end
    end

    context "when name doesn't start with a letter" do
      it "should not be valid" do
        subject.name = "_name"
        expect(subject.valid?).to be false
      end

      it "should not be valid" do
        subject.name = "1name"
        expect(subject.valid?).to be false
      end
    end

    context "when name ends with an underscore" do
      it "should not be valid" do
        subject.name = "name_"
        expect(subject.valid?).to be false
      end
    end

    context "when name contains invalid characters" do
      it "should not be valid" do
        subject.name = "name + !"
        expect(subject.valid?).to be false
      end
    end
  end

  describe ".before_save" do
    it "should set created_at, id, and updated_at in the schema" do
      subject.save
      expect(subject.schema["created_at"]["type"]).to eq "date"
      expect(subject.schema["id"]["type"]).to eq "string"
      expect(subject.schema["updated_at"]["type"]).to eq "date"
    end
  end

  describe "#add_column" do
    let(:action) do
      subject.add_column(name,
        required: false, relationship_to: relationship_to, type: type
      )
    end
    let(:formatted_column_name) { name.split(" ").join("_").downcase }
    let(:name)            { "First Name" }
    let(:relationship_to) { "User" }
    let(:type)            { "string" }

    context "when column does not exist in the schema" do
      it "should have the correct info in the schema" do
        action
        expect(
          subject.schema[formatted_column_name]["created_at"]
        ).to be_present
        expect(subject.schema[formatted_column_name]["required"]).to eq false
        expect(subject.schema[formatted_column_name]["relationship_to"]).to eq(
          relationship_to
        )
        expect(subject.schema[formatted_column_name]["type"]).to eq "string"
        expect(
          subject.schema[formatted_column_name]["updated_at"]
        ).to be_present
      end
    end

    context "when column already exists in the schema" do
      before { action }

      it "should not change the created_at value in the schema" do
        subject.add_column(
          name, relationship_to: "Car", required: true, type: "number"
        )
        expect(subject.schema[formatted_column_name]["relationship_to"]).to eq(
          "Car"
        )
        expect(subject.schema[formatted_column_name]["required"]).to be true
        expect(subject.schema[formatted_column_name]["type"]).to eq "number"
      end
    end
  end

  describe "#remove_column" do
    it "should remove the column from the schema" do
      subject.schema = { "name" => {} }
      subject.remove_column "name"
      expect(subject.schema).not_to have_key "name"
    end
  end
end
