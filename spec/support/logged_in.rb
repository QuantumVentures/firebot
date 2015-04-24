shared_context :logged_in do
  let(:backend_app) { create :backend_app, user: user }
  let(:user)        { create :user }

  before { controller.log_in user }
end
