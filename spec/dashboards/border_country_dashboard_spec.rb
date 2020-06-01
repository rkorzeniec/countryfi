# frozen_string_literal: true

describe BorderCountryDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      country: Administrate::BaseDashboard::Field::BelongsTo,
      border_country: Administrate::BaseDashboard::Field::BelongsTo.with_options(
        class_name: 'Country'
      ),
      id: Administrate::BaseDashboard::Field::Number,
      border_country_id: Administrate::BaseDashboard::Field::Number,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[country border_country].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[id border_country country created_at updated_at].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[country border_country].freeze
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
