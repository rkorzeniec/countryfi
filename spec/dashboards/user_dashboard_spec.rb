# frozen_string_literal: true

describe UserDashboard do
  it do
    expect(described_class::ATTRIBUTE_TYPES).to eq(
      checkins: Administrate::BaseDashboard::Field::HasMany,
      countries: Administrate::BaseDashboard::Field::HasMany,
      id: Administrate::BaseDashboard::Field::Number,
      email: Administrate::BaseDashboard::Field::String,
      jti_token: Administrate::BaseDashboard::Field::String,
      encrypted_jti: Administrate::BaseDashboard::Field::Password,
      encrypted_password: Administrate::BaseDashboard::Field::Password,
      reset_password_token: Administrate::BaseDashboard::Field::Password,
      reset_password_sent_at: Administrate::BaseDashboard::Field::DateTime,
      remember_created_at: Administrate::BaseDashboard::Field::DateTime,
      sign_in_count: Administrate::BaseDashboard::Field::Number,
      current_sign_in_at: Administrate::BaseDashboard::Field::DateTime,
      last_sign_in_at: Administrate::BaseDashboard::Field::DateTime,
      current_sign_in_ip: Administrate::BaseDashboard::Field::String,
      last_sign_in_ip: Administrate::BaseDashboard::Field::String,
      preferences: Administrate::BaseDashboard::Field::String.with_options(
        searchable: false
      ),
      created_at: Administrate::BaseDashboard::Field::DateTime,
      updated_at: Administrate::BaseDashboard::Field::DateTime
    )
  end

  it do
    expect(described_class::COLLECTION_ATTRIBUTES).to eq(
      %i[id email countries].freeze
    )
  end

  it do
    expect(described_class::SHOW_PAGE_ATTRIBUTES).to eq(
      %i[
        id
        email
        jti_token
        sign_in_count
        preferences
        created_at
        updated_at
        countries
        checkins
      ].freeze
    )
  end

  it do
    expect(described_class::FORM_ATTRIBUTES).to eq(
      %i[email encrypted_password].freeze
    )
  end

  it do
    expect(described_class::COLLECTION_FILTERS).to be_empty
  end

  describe '#display_resource' do
    subject { described_class.new.display_resource(user) }

    let(:user) { build_stubbed(:user) }

    it { is_expected.to eq(user.email) }
  end
end
