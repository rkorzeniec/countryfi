describe CountriesController do
  let!(:country) { create(:country) }

  describe 'GET show' do
    before { get(:show, params: params) }

    context 'html' do
      let(:params) { { id: country.id, format: :html } }

      it do
        expect(response).to be_successful
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
