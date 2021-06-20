# frozen_string_literal: true

describe ExploresController do
  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, { params: {} }]
    ]
  end

  context 'when user signed in' do
    let(:user) { create(:user) }
    before { sign_in(user) }

    describe 'GET index' do
      it do
        expect(ExploreFacade).to receive(:new)
          .with(user: user, scope: nil)
          .and_call_original

        get(:index)

        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(assigns(:explore_facade)).to be_kind_of(ExploreFacade)
      end

      context 'with scope' do
        it do
          expect(ExploreFacade).to receive(:new)
            .with(user: user, scope: 'europe')
            .and_call_original

          get(:index, params: { scope: 'europe' })

          expect(response).to be_successful
          expect(response).to render_template(:index)
          expect(assigns(:explore_facade)).to be_kind_of(ExploreFacade)
        end
      end
    end
  end
end
