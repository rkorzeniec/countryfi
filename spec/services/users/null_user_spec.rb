# frozen_string_literal: true

describe Users::NullUser do
  let(:null_user) { described_class.new }

  describe '#cache_key' do
    subject { null_user.cache_key }

    it { is_expected.to eq('null') }
  end

  describe '#countries' do
    subject { null_user.countries }

    it { is_expected.to eq(Country.none) }
  end

  describe '#countries_preference' do
    subject { null_user.countries_preference }

    it { is_expected.to eq('all') }
  end

  describe '#id' do
    subject { null_user.id }

    it { is_expected.to eq(nil) }
  end

  describe '#past_checkins' do
    subject { null_user.past_checkins }

    it { is_expected.to eq(Checkin.none) }
  end

  describe '#public_profile?' do
    subject { null_user.public_profile? }

    it { is_expected.to eq(false) }
  end

  describe '#public_profile' do
    subject { null_user.public_profile }

    it { is_expected.to eq(false) }
  end
end
