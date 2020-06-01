# frozen_string_literal: true
describe Checkins::WorldsController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  context 'when user signed in' do
    let(:country) { create(:country) }
    let(:country_b) { create(:country, :asian) }
    let!(:checkin) do
      create(:checkin, user: user, country: country, checkin_date: '2017-02-01')
    end
    let!(:checkin_b) do
      create(:checkin, user: user, country: country, checkin_date: '2017-01-01')
    end
    let!(:checkin_c) do
      create(:checkin, user: user, country: country_b, checkin_date: '2018-01-01')
    end

    before { sign_in(user) }

    describe 'GET index' do
      before { get(:index) }

      it do
        timeline_items = assigns(:timeline).items

        expect(response).to be_successful
        expect(subject).to render_template(:index)
        expect(timeline_items.count).to eq(3)
        expect(timeline_items.first.checkin).to eq(checkin_c)
        expect(timeline_items.second.checkin).to eq(checkin)
        expect(timeline_items.third.checkin).to eq(checkin_b)
      end
    end
  end
end
