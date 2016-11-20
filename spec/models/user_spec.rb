describe User do
  it { is_expected.to have_many(:checkins) }
  it { is_expected.to have_many(:countries).through(:checkins) }

  context 'destroys chheckins' do
    let!(:user) { create(:user) }
    let!(:country) { create(:country) }
    let!(:checkin) { create(:checkin, user: user, country: country) }

    it { expect { user.destroy }.to change { Checkin.count }.from(1).to(0) }
  end
end
