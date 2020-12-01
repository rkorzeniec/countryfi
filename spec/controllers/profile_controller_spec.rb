# frozen_string_literal: true

describe ProfileController do
  let(:user) { create(:user) }
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

  describe 'GET show' do
    context 'when user not authenticated' do
      it_behaves_like 'authentication_protected_controller', [
        [:get, :show, { params: {} }]
      ]

      context 'with profile name param' do
        it do
          get :show, params: { profile_name: 'mambo' }

          expect(response).to be_successful
          expect(response).to render_template(:show)
          expect(flash[:info]).to be_nil
          expect(assigns(:user)).to be_a(Users::NullUser)
        end

        context 'when profile exists' do
          let!(:user) { create(:user, public_profile: true, profile: 'mambo') }

          it do
            get :show, params: { profile_name: 'mambo' }

            expect(response).to be_successful
            expect(response).to render_template(:show)
            expect(flash[:info]).to eq('You are visiting "mambo" profile')
            expect(assigns(:user)).to eq(user)
          end
        end
      end
    end

    context 'when user signed in' do
      before { sign_in(user) }

      it do
        get :show, params: {}

        expect(response).to be_successful
        expect(response).to render_template(:show)
      end

      context 'with profile name param' do
        it do
          get :show, params: { profile_name: 'mambo' }

          expect(response).to be_successful
          expect(response).to render_template(:show)
          expect(assigns(:user)).to be_a(Users::NullUser)
        end

        context 'when profile exists' do
          let!(:user) { create(:user, public_profile: true, profile: 'mambo') }

          it do
            get :show, params: { profile_name: 'mambo' }

            expect(response).to be_successful
            expect(response).to render_template(:show)
            expect(flash[:info]).to eq('You are visiting "mambo" profile')
            expect(assigns(:user)).to eq(user)
          end
        end
      end
    end
  end
end
