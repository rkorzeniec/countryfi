# frozen_string_literal: true

describe CurrencyDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      country: Administrate::BaseDashboard::Field::BelongsTo,
      id: Administrate::BaseDashboard::Field::Number,
      code: Administrate::BaseDashboard::Field::String,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id country code created_at].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[id country code created_at updated_at].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[country code].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end
end
