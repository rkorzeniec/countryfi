describe CountriesController do
  let(:user) { create(:user) }
  let!(:country) { create(:country) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :show, { id: 1 }]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET show' do
      before { get(:show, params) }

      context 'html' do
        let(:params) { { id: country.id, format: :html } }

        it { expect(response).to be_success }
        it { expect(subject).to render_template(:show) }
        it { expect(assigns(:country)).to eq(country) }
        it { expect(response.body).to include(country.name_common) }
      end

      context 'json' do
        let(:params) { { id: country.id, format: :json } }
        let(:geojson) do
          File.read("app/assets/geojsons/#{country.cca3}.geo.json")
        end

        it { expect(response.body).to eq(geojson) }
      end
    end
  end
end
