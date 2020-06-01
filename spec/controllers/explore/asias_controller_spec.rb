# frozen_string_literal: true
describe Explore::AsiasController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      subject { get(:index) }

      it do
        subject
        expect(response).to be_successful
        expect(subject).to render_template(:index)
        expect(assigns(:explore_facade)).to be_kind_of(ExploreFacade)
      end
    end
  end
end
