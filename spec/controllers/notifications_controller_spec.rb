# frozen_string_literal: true

describe NotificationsController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  describe 'GET index' do
    subject { get(:index, format: :json) }

    before { sign_in(user) }

    context 'without notifications' do
      it do
        expect(subject).to render_template(:index)
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'with read notifications' do
      let!(:notification) { create(:notification, recipient: user) }

      it do
        expect(subject).to render_template(:index)
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'with unread notifications' do
      let(:user_b) { create(:user) }

      let!(:notification) { create(:notification, :unread, recipient: user) }
      let!(:notification_b) { create(:notification, :unread, recipient: user_b) }

      let(:rendered_template) do
        "<div class='dropdown-item-text notification-item text-sm text-muted' " \
        "id='notification-#{notification.id}'>\n" \
        "<div class='d-flex justify-content-between'>\nMambo jambo\n" \
        '<a data-behavior="notification-link" href="#">' \
        "<i class='fas fa-times text-xs d-block d-sm-none'></i>\n" \
        "</a></div>\n</div>\n"
      end

      let(:expected_response) do
        [
          {
            'id' => notification.id,
            'template' => rendered_template
          }
        ]
      end

      it do
        expect(subject).to render_template(:index)
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe 'POST mark_as_read' do
    subject { post(:mark_as_read, format: format, params: params) }

    let(:params) { {} }
    let(:now) { Time.zone.local(2020, 6, 21, 13, 46) }

    before do
      Timecop.freeze(now)
      sign_in(user)
    end

    after { Timecop.return }

    context 'when member' do
      let(:params) { { id: notification.id } }
      let(:notification) { create(:notification, :unread, recipient: user) }
      let(:format) { :json }

      it do
        expect { subject }.to change { notification.reload.read_at }
          .from(nil).to(now)

        expect(JSON.parse(response.body)).to eq(
          { 'success' => true, 'id' => notification.id }
        )
      end

      context 'when read' do
        let(:notification) do
          create(:notification, recipient: user, read_at: now - 1.second)
        end

        it do
          expect { subject }.not_to change { notification.read_at }
          expect(JSON.parse(response.body)).to eq(
            { 'success' => true, 'id' => notification.id }
          )
        end
      end
    end

    context 'when collection' do
      let(:format) { :js }

      let(:user_b) { create(:user) }

      let!(:notification) { create(:notification, :unread, recipient: user) }
      let!(:notification_b) { create(:notification, :unread, recipient: user) }
      let!(:notification_c) { create(:notification, :unread, recipient: user_b) }
      let!(:notification_d) do
        create(:notification, recipient: user, read_at: now - 1.day)
      end

      it do
        expect { subject }.to change { notification.reload.read_at }
          .from(nil).to(now)
          .and change { notification_b.reload.read_at }.from(nil).to(now)

        expect(notification_c.reload.read_at).to be_nil
        expect(notification_d.reload.read_at).to eq(now - 1.day)

        expect(response).to render_template(:mark_as_read)
      end
    end
  end
end
