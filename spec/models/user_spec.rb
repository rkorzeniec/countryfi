describe User do
  it { is_expected.to have_many(:checkins) }
  it { is_expected.to have_many(:countries).through(:checkins) }

  describe 'delegations' do
    it do
      is_expected.to delegate_method(:european).to(:countries).with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:north_american).to(:countries)
        .with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:south_american).to(:countries)
        .with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:asian).to(:countries).with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:oceanian).to(:countries).with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:african).to(:countries).with_prefix(true)
    end
    it do
      is_expected.to delegate_method(:antarctican).to(:countries)
        .with_prefix(true)
    end
  end

  context 'destroys checkins' do
    let!(:user) { create(:user) }
    let!(:country) { create(:country) }
    let!(:checkin) { create(:checkin, user: user, country: country) }

    it { expect { user.destroy }.to change { Checkin.count }.from(1).to(0) }
  end
end
