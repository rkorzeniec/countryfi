describe Checkins::SouthAmericansController do
  let(:user) { create(:user) }
  let(:country) { create(:country, :south_american) }
  let(:country_b) { create(:country) }
  let!(:checkin) { create(:checkin, user: user, country: country) }
  let!(:checkin_b) { create(:checkin, user: user, country: country_b) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      before { get(:index) }

      it do
        expect(response).to be_success
        expect(subject).to render_template(:index)
        expect(assigns(:checkins)).to eq([checkin])
        expect(assigns(:checkins).count).to eq(1)
      end
    end
  end
end
