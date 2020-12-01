# frozen_string_literal: true

describe User, type: :model do
  it { is_expected.to have_secure_token(:jti_token) }

  it { is_expected.to have_many(:checkins).dependent(:destroy) }

  it do
    expect(subject).to have_many(:past_checkins)
      .class_name('Checkin')
      .inverse_of(:user)
  end

  it do
    expect(subject).to have_many(:visited_countries)
      .source(:country)
      .through(:past_checkins)
  end

  it do
    is_expected.to have_many(:notifications)
      .with_foreign_key(:recipient_id)
      .dependent(:destroy)
      .inverse_of(:recipient)
  end

  describe 'countries extended associations' do
    subject { user.visited_countries }

    let(:user) { create(:user) }
    let(:country) { create(:country) }

    context 'when no yet visited' do
      let!(:checkin) do
        create(
          :checkin,
          user: user,
          country:
          country,
          checkin_date: Time.zone.now + 1.day
        )
      end

      it { expect(subject).to eq([]) }
    end

    context 'when already visited' do
      let!(:checkin) do
        create(
          :checkin,
          user: user,
          country: country,
          checkin_date: Time.zone.now - 1.day
        )
      end

      it { expect(subject).to eq([country]) }
    end
  end

  describe 'delegations' do
    it do
      expect(subject).to delegate_method(:european).to(:countries).with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:north_american)
        .to(:countries)
        .with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:south_american)
        .to(:countries)
        .with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:asian).to(:countries).with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:oceanian).to(:countries).with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:african).to(:countries).with_prefix(true)
    end

    it do
      expect(subject).to delegate_method(:antarctican)
        .to(:countries)
        .with_prefix(true)
    end
  end

  context 'when destroys checkins' do
    let!(:user) { create(:user) }
    let!(:country) { create(:country) }
    let!(:checkin) { create(:checkin, user: user, country: country) }

    it { expect { user.destroy }.to change(Checkin, :count).from(1).to(0) }
  end

  describe '#remember_me' do
    subject { user.remember_me }

    let(:user) { build_stubbed(:user) }

    it { is_expected.to be true }
  end

  describe '#countries' do
    subject { user.countries }

    let(:user) { create(:user) }

    let!(:checkin_a) { create(:checkin, user: user, country: country_a) }
    let!(:checkin_b) { create(:checkin, user: user, country: country_b) }
    let!(:checkin_c) { create(:checkin, user: user, country: country_c) }

    let(:country_a) { create(:country, independent: true, un_member: false) }
    let(:country_b) { create(:country, independent: false, un_member: true) }
    let(:country_c) { create(:country, independent: false, un_member: false) }

    context 'when all' do
      it { is_expected.to eq([country_a, country_b, country_c]) }
    end

    context 'when independent' do
      let(:user) { create(:user, countries_cluster: 'independent') }

      it { is_expected.to eq([country_a]) }
    end

    context 'when un member' do
      let(:user) { create(:user, countries_cluster: 'un_member') }

      it { is_expected.to eq([country_b]) }
    end
  end

  describe '#countries_preference' do
    subject { user.countries_preference }

    context 'when nil' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to eq('all') }
    end

    context 'when all' do
      let(:user) { build_stubbed(:user, countries_cluster: 'all') }

      it { is_expected.to eq('all') }
    end

    context 'when independent' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to eq('independent') }
    end

    context 'when un_member' do
      let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }

      it { is_expected.to eq('un_member') }
    end
  end

  describe '#independent_countries_preference?' do
    subject { user.independent_countries_preference? }

    context 'when nil' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to be false }
    end

    context 'when all' do
      let(:user) { build_stubbed(:user, countries_cluster: 'all') }

      it { is_expected.to be false }
    end

    context 'when independent' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to be true }
    end

    context 'when un_member' do
      let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }

      it { is_expected.to be false }
    end
  end

  describe '#un_countries_preference?' do
    subject { user.un_countries_preference? }

    context 'when nil' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to be false }
    end

    context 'when all' do
      let(:user) { build_stubbed(:user, countries_cluster: 'all') }

      it { is_expected.to be false }
    end

    context 'when independent' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to be false }
    end

    context 'when un_member' do
      let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }

      it { is_expected.to be true }
    end
  end

  describe '#public_profile?' do
    subject { user.public_profile? }

    context 'when nil' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.to be false }
    end

    context 'when false' do
      let(:user) { build_stubbed(:user, public_profile: false) }

      it { is_expected.to be false }
    end

    context 'when true' do
      let(:user) { build_stubbed(:user, public_profile: true) }

      it { is_expected.to be true }
    end
  end
end
