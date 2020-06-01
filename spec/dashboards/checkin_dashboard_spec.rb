# frozen_string_literal: true

describe CheckinDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      user: Administrate::BaseDashboard::Field::BelongsTo,
      country: Administrate::BaseDashboard::Field::BelongsTo,
      id: Administrate::BaseDashboard::Field::Number,
      checkin_date: Administrate::BaseDashboard::Field::DateTime,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id user country checkin_date].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[id user country checkin_date created_at updated_at].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[user country checkin_date].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end
end
