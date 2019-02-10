describe DashboardController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      let(:country) { create(:country) }
      let(:facade) do
        double(
          'dashboard',
          country_id: country.id,
          european_country_id: country.id,
          north_american_country_id: country.id,
          south_american_country_id: country.id,
          asian_country_id: country.id,
          african_country_id: country.id,
          oceanian_country_id: country.id,
          antarctican_country_id: country.id,
          country_code_array: [country.cca2]
        )
      end

      before do
        allow(DashboardFacade).to receive(:new).and_return(facade)
        get(:index)
      end

      it do
        expect(response).to be_successful
        expect(subject).to render_template(:index)
        expect(assigns(:dashboard)).to eq(facade)
      end
    end
  end
end
