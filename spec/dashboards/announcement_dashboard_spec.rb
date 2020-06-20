# frozen_string_literal: true

describe AnnouncementDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      id: Administrate::BaseDashboard::Field::Number,
      message: Administrate::BaseDashboard::Field::String,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id message created_at].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[id message created_at updated_at].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[message].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end
end
