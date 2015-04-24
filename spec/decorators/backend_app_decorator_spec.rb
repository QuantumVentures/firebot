require "rails_helper"

describe BackendAppDecorator do
  let(:description) { "description" }
  let(:object)      { create :backend_app, description: description }

  subject { object.decorate }

  describe "#description" do
    context "when description is present" do
      it "should return the description" do
        expect(subject.description).to eq description
      end
    end

    context "when description is not present" do
      let(:description) { nil }

      it "should return 'no description available'" do
        expect(subject.description).to eq "no description available"
      end
    end
  end
end
