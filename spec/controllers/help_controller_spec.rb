require "rails_helper"

describe HelpController do
  describe "GET index" do
    before { get :index }

    it { should respond_with :success }
  end
end
