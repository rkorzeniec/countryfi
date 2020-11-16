# frozen_string_literal: true

describe DashboardController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, { params: {} }]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      let(:country) { build_stubbed(:country) }
      let(:counter) do
        instance_double(
          'counter',
          visited_world_countries_count: 1,
          visited_european_countries_count: 1,
          visited_north_american_countries_count: 1,
          visited_south_american_countries_count: 1,
          visited_asian_countries_count: 1,
          visited_african_countries_count: 1,
          visited_oceanian_countries_count: 1,
          visited_antarctican_countries_count: 1
        )
      end
      let(:facade) do
        instance_double(
          'dashboard',
          country: country,
          countries_count: 28,
          european_countries_count: 1,
          north_american_countries_count: 2,
          south_american_countries_count: 3,
          asian_countries_count: 4,
          african_countries_count: 5,
          oceanian_countries_count: 6,
          antarctican_countries_count: 7,
          visited_countries_count: 14,
          visited_european_countries_count: 0,
          visited_north_american_countries_count: 2,
          visited_south_american_countries_count: 2,
          visited_asian_countries_count: 3,
          visited_african_countries_count: 3,
          visited_oceanian_countries_count: 3,
          visited_antarctican_countries_count: 5,
          country_counts_array: [[country.cca2, 1]],
          yearly_countries_chart: double('decorator', labels: [], series: []),
          top_countries_chart_data: {},
          top_regions_chart_data: {}
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
