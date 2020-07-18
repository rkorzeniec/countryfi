# frozen_string_literal: true

describe Checkins::NorthAmericansController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, { params: {} }]
    ]
  end

  context 'when user signed in' do
    let(:country) { create(:country, :north_american) }
    let(:country_b) { create(:country) }
    let!(:checkin) do
      create(:checkin, user: user, country: country, checkin_date: '2017-02-01')
    end
    let!(:checkin_b) do
      create(:checkin, user: user, country: country, checkin_date: '2017-01-01')
    end
    let!(:checkin_c) { create(:checkin, user: user, country: country_b) }

    before { sign_in(user) }

    describe 'GET index' do
      subject { get(:index) }

      it do
        expect(Checkins::TimelineFacade).to receive(:new)
          .with([checkin, checkin_b]).and_call_original

        subject
        timeline_items = assigns(:timeline).items

        expect(response).to be_successful
        expect(subject).to render_template(:index)
        expect(timeline_items.count).to eq(2)
        expect(timeline_items.first.checkin).to eq(checkin)
        expect(timeline_items.second.checkin).to eq(checkin_b)
      end
    end
  end
end
