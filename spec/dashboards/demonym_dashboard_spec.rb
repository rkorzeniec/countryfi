# frozen_string_literal: true

describe DemonymDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      country: Administrate::BaseDashboard::Field::BelongsTo,
      id: Administrate::BaseDashboard::Field::Number,
      locale: Administrate::BaseDashboard::Field::String,
      gender: Administrate::BaseDashboard::Field::String,
      name: Administrate::BaseDashboard::Field::String,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id locale gender name].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[
        id
        country
        locale
        gender
        name
        created_at
        updated_at
      ].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[
        country
        locale
        gender
        name
      ].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end
end
