require "rails_helper"

describe BackendAppsController do
  let(:user) { create :user }

  before { controller.log_in user }

  describe "#new" do
    before { get :new }

    it { should respond_with :success }
  end
end
