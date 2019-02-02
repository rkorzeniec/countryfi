describe ExploreController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      before { get(:index) }

      context 'html' do

        it do
          expect(response).to be_successful
          expect(subject).to render_template(:index)
        end
      end
    end
  end
end
