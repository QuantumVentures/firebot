require "rails_helper"

describe Log do
  subject { build :log }

  it { should validate_presence_of :description }
  it { should validate_presence_of :loggable }
  it { should validate_presence_of :responsible }

  it { should be_valid }

  it_should_behave_like :crud

  it { should belong_to :loggable }
  it { should belong_to :responsible }

  describe ".completed" do
    let(:log) { create :log, completed_at: Time.zone.now }

    before { log }

    it "should have a completed log" do
      expect(Log.completed).to include log
    end
  end

  describe ".incompleted" do
    let(:log) { create :log }

    before { log }

    it "should have an incompleted log" do
      expect(Log.incompleted).to include log
    end
  end

  describe "#completed?" do
    context "when completed" do
      before { subject.update completed_at: Time.zone.now }

      it "should be true" do
        expect(subject.completed?).to be true
      end
    end

    context "when not completed" do
      it "should be false" do
        expect(subject.completed?).to be false
      end
    end
  end
end
