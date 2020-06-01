# frozen_string_literal: true

describe Types::CountryType do
  subject { described_class }

  it { is_expected.to have_field(:name_common).of_type('String!') }
  it { is_expected.to have_field(:name_official).of_type('String') }
  it { is_expected.to have_field(:cca2).of_type('String') }
  it { is_expected.to have_field(:ccn3).of_type('String') }
  it { is_expected.to have_field(:cca3).of_type('String') }
  it { is_expected.to have_field(:capital).of_type('String') }
end
