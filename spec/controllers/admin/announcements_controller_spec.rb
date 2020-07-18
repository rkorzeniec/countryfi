# frozen_string_literal: true

describe Admin::AnnouncementsController do
  let(:announcement) { create(:announcement) }

  context 'when user not authenticated' do
    it_behaves_like 'protected_admin_controller', [
      [:get, :index, { params: {} }],
      [:get, :new, { params: {} }],
      [:get, :edit, { params: { id: 1 } }],
      [:put, :update, { params: { id: 1 } }],
      [:post, :create, { params: {} }],
      [:delete, :destroy, { params: { id: 1 } }]
    ]
  end

  context 'when user signed in' do
    let(:user) { create(:user, admin: true) }

    before { sign_in(user) }

    it 'index' do
      get(:index)
      expect(response.status).to eq(200)
    end

    it 'new' do
      get(:new)
      expect(response.status).to eq(200)
    end

    it 'edit' do
      get(:edit, params: { id: announcement.id })
      expect(response.status).to eq(200)
    end

    it 'delete' do
      post(:destroy, params: { id: announcement.id })
      expect(response.status).to eq(302)
    end

    describe '#create' do
      subject { post(:create, params: params) }

      context 'when successful' do
        let(:params) { { announcement: { message: 'Super mambo test' } } }

        it do
          expect(Admin::AnnouncementNotificationsCreator).to receive(:new)
            .with(a_kind_of(Announcement)).and_call_original

          expect { subject }.to change { Announcement.count }
            .from(0).to(1)
            .and change { Delayed::Job.count }
            .from(0).to(1)

          new_announcement = Announcement.last
          expect(response).to redirect_to(
            admin_announcement_path(new_announcement)
          )
        end
      end

      context 'when successful' do
        let(:params) { { announcement: { message: nil } } }

        it do
          expect { subject }.not_to change { Announcement.count }
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
