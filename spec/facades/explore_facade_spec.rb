# frozen_string_literal: true

describe ExploreFacade do
  let(:region) { 'north_america' }
  let(:subregion) { 'carribean' }
  let(:countries) { nil }
  let(:user) do
    instance_double(
      User,
      selected_countries: countries,
      independent_countries_preference: nil,
      un_countries_preference: nil
    )
  end
  let(:facade) do
    described_class.new(
      user: user, region: region, subregions: subregion
    )
  end

  describe '#discoverable_countries' do
    subject { facade.discoverable_countries }

    context 'when no visited countries' do
      it { is_expected.to be_empty }

      it do
        expect(UnvisitedCountriesQuery).to receive(:new)
          .with(user: user, regions: region, subregions: subregion)
          .and_call_original

        expect_any_instance_of(UnvisitedCountriesQuery)
          .to receive(:all)
          .and_call_original
        subject
      end
    end

    context 'when visited countries' do
      let!(:country) { build_stubbed(:country) }
      let(:countries) { [country] }

      it do
        expect(UnvisitedCountriesQuery).to receive(:new)
          .with(user: user, regions: region, subregions: subregion)
          .and_call_original
        expect_any_instance_of(UnvisitedCountriesQuery)
          .to receive(:all)
          .and_call_original
        subject
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
