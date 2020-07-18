# frozen_string_literal: true

describe CountryDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      checkins: Administrate::BaseDashboard::Field::HasMany,
      currencies: Administrate::BaseDashboard::Field::HasMany,
      top_level_domains: Administrate::BaseDashboard::Field::HasMany,
      country_languages: Administrate::BaseDashboard::Field::HasMany,
      country_calling_codes: Administrate::BaseDashboard::Field::HasMany,
      border_countries: Administrate::BaseDashboard::Field::HasMany,
      country_alternative_spellings: Administrate::BaseDashboard::Field::HasMany,
      id: Administrate::BaseDashboard::Field::Number,
      name_common: Administrate::BaseDashboard::Field::String,
      name_official: Administrate::BaseDashboard::Field::String,
      cca2: Administrate::BaseDashboard::Field::String,
      ccn3: Administrate::BaseDashboard::Field::String,
      cca3: Administrate::BaseDashboard::Field::String,
      cioc: Administrate::BaseDashboard::Field::String,
      capital: Administrate::BaseDashboard::Field::String,
      independent: Administrate::BaseDashboard::Field::Boolean,
      status: Administrate::BaseDashboard::Field::String,
      region: Administrate::BaseDashboard::Field::String,
      subregion: Administrate::BaseDashboard::Field::String,
      landlocked: Administrate::BaseDashboard::Field::Boolean,
      area: Administrate::BaseDashboard::Field::Number.with_options(decimals: 2),
      demonym: Administrate::BaseDashboard::Field::String,
      flag: Administrate::BaseDashboard::Field::String,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime,
      latitude: Administrate::BaseDashboard::Field::String.with_options(
        searchable: false
      ),
      longitude: Administrate::BaseDashboard::Field::String.with_options(
        searchable: false
      )
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id name_common].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[
        id
        name_common
        name_official
        cca2
        ccn3
        cca3
        cioc
        capital
        independent
        status
        region
        subregion
        landlocked
        area
        demonym
        created_at
        updated_at
        latitude
        longitude
        checkins
        currencies
        top_level_domains
        country_languages
        country_calling_codes
        border_countries
        country_alternative_spellings
      ].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[
        checkins
        currencies
        top_level_domains
        country_languages
        country_calling_codes
        border_countries
        country_alternative_spellings
        name_common
        name_official
        cca2
        ccn3
        cca3
        cioc
        capital
        independent
        status
        region
        subregion
        landlocked
        area
        demonym
        latitude
        longitude
      ].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end

  describe '#display_resource' do
    subject { described_class.new.display_resource(country) }

    let(:country) { build_stubbed(:country) }

    it { is_expected.to eq(country.name_common) }
  end
end
