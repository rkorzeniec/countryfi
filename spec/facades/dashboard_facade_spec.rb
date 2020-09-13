# frozen_string_literal: true

describe DashboardFacade do
  let(:user) { build_stubbed(:user) }
  let(:facade) { described_class.new(user) }

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) { ['dashboard_facade', method_name, user.cache_key].join('/') }

    it do
      expect(Rails).to receive(:cache).and_return(cache)
      expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
      subject
    end
  end

  describe 'delegations' do
    subject { facade }
    %i[
      countries european_countries north_american_countries south_american_countries
      asian_countries african_countries oceanian_countries antarctican_countries
    ].each do |region|
      it do
        is_expected.to delegate_method("#{region}_count".to_sym)
          .to(:countries_counter)
      end

      it do
        is_expected.to delegate_method("#{region}_count".to_sym)
          .to(:visited_countries_counter)
          .with_prefix(:visited)
      end
    end
  end

  describe '#country_code_array' do
    subject { facade.country_code_array }

    let(:country_a) { build_stubbed(:country, cca2: 'AA') }
    let(:country_b) { build_stubbed(:country, cca2: 'BB') }
    let(:country_c) { build_stubbed(:country, cca2: 'AA') }
    let(:countries) { [country_a, country_b] }

    before do
      allow(facade).to receive(:user_countries).and_return(countries)
    end

    it { expect(subject).to eq(%w[AA BB]) }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'country_code_array' }
    end
  end

  describe '#countries_yearly_chart_data' do
    subject { facade.countries_yearly_chart_data }

    let(:unique_query) do
      instance_double(UniqVisitedCountriesQuery, count_by_year: [1, 2, 3])
    end
    let(:all_query) do
      instance_double(VisitedCountriesQuery, count_by_year: [4, 5, 6])
    end

    it do
      expect(VisitedCountriesQuery).to receive(:new)
        .with(user).and_return(all_query)
      expect(UniqVisitedCountriesQuery).to receive(:new)
        .with(user).and_return(unique_query)

      is_expected.to eq(
        [
          { name: 'all', query: [4, 5, 6] },
          { name: 'unique', query: [1, 2, 3] }
        ]
      )
    end

    it_behaves_like 'with cached method' do
      let(:method_name) { 'countries_yearly_chart_data' }
    end
  end

  describe '#top_countries_chart_data' do
    subject { facade.top_countries_chart_data }

    let(:query) do
      instance_double(TopCountriesQuery, query: { 'CH' => 2, 'CN' => 4 })
    end

    it do
      expect(TopCountriesQuery).to receive(:new).and_return(query)
      is_expected.to eq({ 'CH' => 2, 'CN' => 4 })
    end

    it_behaves_like 'with cached method' do
      let(:method_name) { 'top_countries_chart_data' }
    end
  end

  describe '#top_regions_chart_data' do
    subject { facade.top_regions_chart_data }

    let(:query) do
      instance_double(
        TopRegionsQuery,
        query: { 'Caribbean' => 2, 'North America' => 4 }
      )
    end

    it do
      expect(TopRegionsQuery).to receive(:new).and_return(query)
      is_expected.to eq({ 'Caribbean' => 2, 'North America' => 4 })
    end

    it_behaves_like 'with cached method' do
      let(:method_name) { 'top_regions_chart_data' }
    end
  end

  describe '#cache_key' do
    subject { facade.send(:cache_key, 'asian_countries') }

    it { is_expected.to eq("dashboard_facade/asian_countries/#{user.cache_key}") }
  end
end
