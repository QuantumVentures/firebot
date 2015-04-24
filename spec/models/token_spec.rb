require "rails_helper"

describe Token do
  let(:token) { create :token }

  subject { build :token }

  it_should_behave_like :crud

  it { should belong_to(:tokenable).touch }
  it { should belong_to :user }

  it { should validate_presence_of :user }
  it { should validate_uniqueness_of :token }

  describe ".before_create" do
    context "#expires_at" do
      it "should set expired_at if lifespan is present" do
        Timecop.freeze do
          expect(subject).to receive(:lifespan).twice.and_return 1.year
          subject.save
          expect(subject.expires_at).to eq 1.year.from_now
        end
      end

      it "should not set expired_at if lifespan is nil" do
        expect(subject).to receive(:lifespan).and_return nil
        subject.save
        expect(subject.expires_at).to be_nil
      end
    end

    context "#token" do
      it "should generate a token by default" do
        subject.token = nil
        subject.save
        expect(subject.token).not_to be_nil
      end

      it "should not overwrite an existing token" do
        subject.token = "example"
        subject.save
        expect(subject.token).to eq "example"
      end
    end

    context "#type" do
      it "should set type to the class name" do
        expect(subject.type).to be_nil
        subject.save
        expect(subject.type).to eq described_class.name
      end
    end
  end

  describe ".active" do
    let(:token_expired) { create :token, :expired }

    before do
      token
      token_expired
    end

    it "should have an active token" do
      expect(Token.active).to include token
    end

    it "should not have an expired token" do
      expect(Token.active).not_to include token_expired
    end
  end

  describe ".most_recent" do
    let(:token_recent) { create :token }

    before do
      token
      token_recent
    end

    it "should return the most recent token" do
      expect(Token.most_recent).to eq token_recent
    end
  end

  describe "#expire!" do
    attributes = %i(expires_at updated_at)

    it "should touch #{attributes.to_sentence}" do
      Timecop.freeze do
        subject.save
        subject.expire!
        now = Time.zone.now

        attributes.each do |attribute|
          expect(subject.send attribute).to eq now
        end
      end
    end
  end

  describe "#expired?" do
    it "should return false if expired_at is nil" do
      subject.expires_at = nil
      expect(subject).not_to be_expired
    end

    it "should return false if expired_at is in the future" do
      subject.expires_at = 1.minute.from_now
      expect(subject).not_to be_expired
    end

    it "should return true if expired_at is in the past" do
      subject.expires_at = 1.second.ago
      expect(subject).to be_expired
    end
  end

  describe "#lifespan" do
    it "should be nil by default" do
      expect(subject.lifespan).to be_nil
    end
  end

  describe "#to_s" do
    it "should be an alias of token" do
      expect(subject).to receive(:token).and_return "example"
      expect(subject.to_s).to eq "example"
    end
  end
end
