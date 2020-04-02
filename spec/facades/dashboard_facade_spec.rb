describe DashboardFacade do
  let(:user) { build_stubbed(:user) }
  let(:facade) { described_class.new(user) }

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) do
      [
        'dashboard_facade',
        method_name,
        user.id
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
    describe "##{region}_countries" do
      subject { facade.send("#{region}_countries".to_sym) }

      let(:countries) { instance_double('countries') }
      let(:countries_relation) { instance_double('relation', load: countries) }

      it_behaves_like 'with cached method' do
        let(:method_name) { "#{region}_countries" }
      end

      it do
        expect(Country).to receive(:all).and_return(countries_relation)
        expect(countries).to receive(region)
        subject
      end
    end
  end

  describe '#country_code_array' do
    subject { facade.country_code_array }

    let(:country_a) { build_stubbed(:country, cca2: 'AA') }
    let(:country_b) { build_stubbed(:country, cca2: 'BB') }
    let(:countries) { [country_a, country_b] }

    before do
      allow(facade).to receive(:visited_countries).and_return(countries)
    end

    it { expect(subject).to eq(%w[AA BB]) }
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

  describe '#cache_key' do
    subject { facade.send(:cache_key, 'asian_countries') }

    let(:country) { instance_double('country', id: 99) }

    before { allow(user).to receive(:visited_checkins).and_return([country]) }

    it { is_expected.to eq("dashboard_facade/asian_countries/#{user.id}/99") }
  end
end
