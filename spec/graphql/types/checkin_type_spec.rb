# frozen_string_literal: true

describe Types::CheckinType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:user).of_type('User') }
  it { is_expected.to have_field(:country).of_type('Country') }
  it { is_expected.to have_field(:checkin_date).of_type('String') }
end
