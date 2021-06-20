# frozen_string_literal: true

describe ExploreFacade do
  let(:facade) { described_class.new(user: user, scope: region) }
  let(:region) { 'north_america' }
  let(:countries) { nil }
  let(:user) do
    instance_double(
      User,
      countries: countries,
      independent_countries_preference?: nil,
      un_countries_preference?: nil
    )
  end

  describe '#discoverable_countries' do
    [
      { scope: 'europe', region: 'Europe', subregion: nil },
      { scope: 'africa', region: 'Africa', subregion: nil },
      { scope: 'asia', region: 'Asia', subregion: nil },
      { scope: 'oceania', region: 'Oceania', subregion: nil },
      { scope: 'antarctica', region: 'Antarctica', subregion: nil },
      {
        scope: 'north_america', region: 'Americas',
        subregion: ['North America', 'Central America', 'Caribbean']
      },
      { scope: 'south_america', region: 'Americas', subregion: 'South America' }
    ].each do |test|
      context "when #{test[:scope]} and no visited countries" do
        it do
          expect(
            described_class.new(user: user, scope: test[:scope]).discoverable_countries
          ).to be_empty
        end

        it do
          expect(UnvisitedCountriesQuery).to receive(:new)
            .with(user: user, regions: test[:region], subregions: test[:subregion])
            .and_call_original

          expect_any_instance_of(UnvisitedCountriesQuery)
            .to receive(:all)
            .and_call_original

          described_class.new(user: user, scope: test[:scope]).discoverable_countries
        end
      end

      context "when #{test[:scope]} and visited countries" do
        let!(:country) { build_stubbed(:country) }
        let(:countries) { [country] }

        it do
          expect(UnvisitedCountriesQuery).to receive(:new)
            .with(user: user, regions: test[:region], subregions: test[:subregion])
            .and_call_original
          expect_any_instance_of(UnvisitedCountriesQuery)
            .to receive(:all)
            .and_call_original

          described_class.new(user: user, scope: test[:scope]).discoverable_countries
        end
      end
    end
  end

  describe '#discoverable_countries_by_category' do
    subject { facade.discoverable_countries_by_category(category) }

    let(:country) { instance_double(Country, name_common: 'France') }
    let(:country_b) { instance_double(Country, name_common: 'Germany') }

    before do
      allow(facade).to receive(:discoverable_countries)
        .and_return([country, country_b])

      allow_any_instance_of(UnvisitedCountriesQuery).to receive(:all)
        .and_return([country, country_b])
    end

    context 'without categories' do
      subject { facade.discoverable_countries_by_category }

      it { is_expected.to eq([country, country_b]) }
    end

    context 'with all categories' do
      let(:category) { 'All' }

      it { is_expected.to eq([country, country_b]) }
    end

    context 'with category' do
      let(:category) { 'G' }

      it { is_expected.to eq([country_b]) }
    end
  end

  describe '#country_categories' do
    subject { facade.country_categories }

    let(:country) { instance_double(Country, name_common: 'France') }
    let(:country_b) { instance_double(Country, name_common: 'Germany') }

    context 'with discoverable countries' do
      before do
        allow(facade).to receive(:discoverable_countries)
          .and_return([country, country_b])
      end

      it { is_expected.to eq(%w[All F G]) }
    end

    context 'without discoverable countries' do
      it { is_expected.to eq(%w[All]) }
    end
  end
end
