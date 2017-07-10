describe Checkins::WorldsController do
  let(:user) { create(:user) }
  let(:country) { create(:country) }
  let(:country_b) { create(:country, :asian) }
  let!(:checkin) { create(:checkin, user: user, country: country) }
  let!(:checkin_b) { create(:checkin, user: user, country: country_b) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      before { get(:index) }

      it do
        expect(response).to be_success
        expect(subject).to render_template(:index)
        expect(assigns(:checkins)).to eq([checkin, checkin_b])
        expect(assigns(:checkins).count).to eq(2)
      end
    end
  end
end
