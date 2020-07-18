# frozen_string_literal: true

describe Admin::ApplicationController do
  controller do
    def index
      head :ok
    end
  end

  context 'when user not authenticated' do
    it_behaves_like 'protected_admin_controller', [[:get, :index, { params: {} }]]
  end

  context 'when signed in admin' do
    let(:user) { create(:user, admin: true) }

    before { sign_in(user) }

    it do
      get(:index)

      expect(response.status).to eq(200)
    end
  end
end
