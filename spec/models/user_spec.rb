describe User, type: :model do
  it { is_expected.to have_secure_token(:jti_token) }

  it { is_expected.to have_many(:checkins).dependent(:destroy) }
  it { is_expected.to have_many(:countries).through(:checkins) }

  it do
    expect(subject).to have_many(:visited_checkins)
      .class_name('Checkin')
      .inverse_of(:user)
  end

  it do
    expect(subject).to have_many(:visited_countries)
      .source(:country)
      .through(:visited_checkins)
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
end
