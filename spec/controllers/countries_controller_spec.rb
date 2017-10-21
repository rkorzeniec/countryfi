describe CountriesController do
  let(:user) { create(:user) }
  let!(:country) { create(:country) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :show, params: { id: 1 }]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET show' do
      before { get(:show, params: params) }

      context 'html' do
        let(:params) { { id: country.id, format: :html } }

        it do
          expect(response).to be_success
          expect(subject).to render_template(:show)
          expect(assigns(:country)).to eq(country)
          expect(response.body).to include(country.name_common)
        end
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
