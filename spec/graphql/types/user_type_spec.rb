# frozen_string_literal: true

describe Types::UserType do
  subject { described_class }

  it { is_expected.to have_field(:id).of_type('ID!') }
  it { is_expected.to have_field(:email).of_type('String!') }
  it { is_expected.to have_field(:checkins).of_type('[Checkin!]') }
  it { is_expected.to have_field(:countries).of_type('[Country!]') }
end
