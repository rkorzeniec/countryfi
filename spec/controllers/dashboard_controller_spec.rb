describe DashboardController do
  let(:user) { create(:user) }
  let(:country) { create(:country) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [[:get, :show]]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET show' do
      before do
        allow(CountryIDLookuper).to receive(:lookup).and_return(country.id)
      end

      before { get(:show) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template(:show) }
    end
  end
end
