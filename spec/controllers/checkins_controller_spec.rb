describe CheckinsController do
  let(:user) { create(:user) }
  let(:country) { create(:country) }
  let!(:checkin) { create(:checkin, user: user, country: country) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index],
      [:get, :new],
      [:get, :edit, { id: 1 }],
      [:put, :update, { id: 1 }],
      [:post, :create],
      [:delete, :destroy, { id: 1 }]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET index' do
      before do
        allow(CountryIDLookuper).to receive(:lookup).and_return(country.id)
      end
      before { get(:index) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template(:index) }
      it { expect(assigns(:checkins)).to include(checkin) }
      it { expect(assigns(:checkins).count).to eq(1) }
      it { expect(response.body).to include(country.name_common) }
    end

    describe 'GET new' do
      before { get(:new) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template(:new) }
    end

    describe 'POST create' do
      context 'when successful' do
        let!(:now) { Time.zone.now }

        subject do
          post(:create, checkin: { country_id: country.id, checkin_date: now })
        end

        it { expect(subject).to redirect_to(checkins_path) }
        it { expect { subject }.to change { Checkin.count }.from(1).to(2) }
        it do
          subject
          expect(flash[:success]).to be_present
        end
      end

      context 'when unsuccessful' do
        subject do
          post(
            :create,
            checkin: { country_id: 'not_id', checkin_date: 'not_date' }
          )
        end

        it { expect(subject).to render_template(:new) }
        it { expect { subject }.not_to change { Checkin.count } }
        it do
          subject
          expect(flash[:error]).to be_present
        end
      end
    end

    describe 'GET edit' do
      before { get(:edit, id: checkin.id) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template(:edit) }
      it { expect(assigns(:checkin)).to eq(checkin) }
      it { expect(response.body).to include(country.name_common) }
    end

    describe 'PUT update' do
      let!(:now) { '2016-01-01' }

      context 'when successful' do

        before { post(:update, id: checkin.id, checkin: { checkin_date: now }) }

        it { expect(response).to redirect_to(checkins_path) }
        it { expect(flash[:success]).to be_present }
        it do
          expect(checkin.reload.checkin_date.strftime('%Y-%m-%d')).to eq(now)
        end
      end

      context 'when unsuccessful' do
        before do
          post(:update, id: checkin.id, checkin: { country_id: 'NaN' })
        end

        it { expect(subject).to render_template(:edit) }
        it { expect(flash[:error]).to be_present }
        it { expect(checkin.reload.country_id).to eq(country.id) }
      end
    end

    describe 'DELETE destroy' do
      context 'when successful' do
        subject { delete(:destroy, id: checkin.id) }

        it { expect(subject).to redirect_to(checkins_path) }
        it { expect { subject }.to change { Checkin.count }.from(1).to(0) }
        it do
          subject
          expect(flash[:success]).to be_present
        end
      end

      context 'when unsuccessful' do
        subject { delete(:destroy, id: checkin.id) }

        before do
          expect_any_instance_of(Checkin).to receive(:destroy).and_return(false)
          subject
        end

        it { expect(subject).to redirect_to(checkins_path) }
        it { expect(flash[:error]).to be_present }
        it { expect { subject }.not_to change { Checkin.count } }
      end
    end
  end
end
