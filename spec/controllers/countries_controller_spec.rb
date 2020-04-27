describe CountriesController do
  let!(:country) { create(:country) }

  describe 'GET show' do
    before { get(:show, params: params) }

    context 'when html' do
      let(:params) { { id: country.cca2, format: :html } }

      it do
        expect(response).to be_successful
        expect(subject).to render_template(:show)
        expect(assigns(:country)).to eq(country)
        expect(assigns(:geojson)).to eq(
          File.read(
            Rails.root.join(
              "app/assets/geojsons/#{country.cca3.downcase}.geo.json"
            )
          )
        )
        expect(response.body).to include(country.name_common)
      end
    end
  end
end
