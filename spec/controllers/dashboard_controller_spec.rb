describe DashboardController do
  let(:user) { create(:user) }
  let(:country) { create(:country) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [[:get, :index]]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      before do
        allow(CountryIDLookuper).to receive(:lookup).and_return(country.id)
      end

      before { get(:index) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template(:index) }
    end
  end
end
