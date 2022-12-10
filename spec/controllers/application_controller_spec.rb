# frozen_string_literal: true

describe ApplicationController do
  controller do
    skip_before_action :authenticate_user!, only: :new

    def index
      head :ok
    end

    def new
      head :ok
    end
  end

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, { params: {} }]
    ]
  end

  context 'when user signed in' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    describe 'GET index' do
      before { get(:index) }

      it do
        expect(response).to be_successful
      end
    end
  end

  describe '#after_sign_in_path_for' do
    subject { controller.after_sign_in_path_for(nil) }

    it do
      is_expected.to eq('/profile')
    end
  end

  describe '#control_rack_mini_profiler' do
    subject { controller.control_rack_mini_profiler }

    context 'when user not authenticated' do
      it do
        expect(Rack::MiniProfiler).not_to receive(:authorize_request)
        get(:index)
      end
    end

    context 'when non-admin signed in' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it do
        expect(Rack::MiniProfiler).not_to receive(:authorize_request)
        get(:index)
      end
    end

    context 'when admin signed in' do
      let(:user) { create(:user, admin: true) }

      before { sign_in(user) }

      it do
        expect(Rack::MiniProfiler).not_to receive(:authorize_request)
        get(:index)
      end

      context 'with rmp param' do
        it do
          expect(Rack::MiniProfiler).to receive(:authorize_request)
          get(:index, params: { rmp: true })
        end
      end
    end
  end

  describe '#set_sentry_context' do
    it 'sets up Sentry' do
      expect(Sentry).to receive(:set_user).with(id: session[:current_user_id])
      expect(Sentry).to receive(:set_extras).with(
        params: { 'action' => 'index', 'controller' => 'anonymous' },
        url: 'http://test.host/anonymous'
      )

      get(:index)
    end
  end

  describe '#set_current_user' do
    context 'when authenticated' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it 'sets up Current with user' do
        expect(Current).to receive(:user=).with(user).and_call_original
        get(:index)
      end
    end

    context 'when unauthenticated' do
      it 'sets up Current with NullUser instance' do
        expect(Current).to receive(:user=).with(an_instance_of(NullUser)).and_call_original
        get(:new)
      end
    end
  end
end
