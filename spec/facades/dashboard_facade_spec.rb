# frozen_string_literal: true

describe DashboardFacade do
  let(:user) { build_stubbed(:user) }
  let(:facade) { described_class.new(user) }

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) do
      [
        'dashboard_facade',
        method_name,
        user.cache_key
      ].join('/')
    end

    it do
      expect(Rails).to receive(:cache).and_return(cache)
      expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
      subject
    end
  end

  %i[
    european north_american south_american asian african oceanian antarctican
  ].each do |region|
    describe "##{region}_countries_count" do
      subject { facade.send("#{region}_countries_count".to_sym) }

      let(:countries_relation) { instance_double('relation') }
      let(:countries) { [double(:country)] }

      it_behaves_like 'with cached method' do
        let(:method_name) { "#{region}_countries_count" }
      end

      context 'with all countries' do
        it do
          expect(Country).to receive(:all).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end

      context 'with independent countries' do
        let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

        it do
          expect(Country).to receive(:independent).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end

      context 'with un countries' do
        let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }
        it do
          expect(Country).to receive(:un_member).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end
    end
  end

  describe '#country_code_array' do
    subject { facade.country_code_array }

    let(:country_a) { build_stubbed(:country, cca2: 'AA') }
    let(:country_b) { build_stubbed(:country, cca2: 'BB') }
    let(:countries) { [country_a, country_b] }

    before do
      allow(facade).to receive(:user_countries).and_return(countries)
    end

    it { expect(subject).to eq(%w[AA BB]) }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'country_code_array' }
    end
  end

  describe '#visited_countries_counter' do
    subject { facade.visited_countries_counter }

    it do
      expect(Dashboard::VisitedCountriesCounter).to receive(:new)
        .with(user)
        .and_call_original
      expect(subject).to be_a(Dashboard::VisitedCountriesCounter)
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

    let(:country) { instance_double('country', id: 99) }

    before { allow(user).to receive(:past_checkins).and_return([country]) }

    it { is_expected.to eq("dashboard_facade/asian_countries/#{user.cache_key}/99") }
  end
end
