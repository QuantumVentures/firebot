require "rails_helper"

describe PagesController do
  describe "GET #index" do
    before { get :index }

    it { should respond_with :success }
  end
end
