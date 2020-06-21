# frozen_string_literal: true

describe NotificationDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      id: Administrate::BaseDashboard::Field::Number,
      notifiable_type: Administrate::BaseDashboard::Field::String,
      notifiable_id: Administrate::BaseDashboard::Field::Number,
      recipient_id: Administrate::BaseDashboard::Field::Number,
      read_at: Administrate::BaseDashboard::Field::DateTime,
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id notifiable_type notifiable_id recipient_id read_at].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[
        id notifiable_type notifiable_id recipient_id read_at created_at updated_at
      ].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[notifiable_type notifiable_id recipient_id].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end
end
