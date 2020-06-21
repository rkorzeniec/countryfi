# frozen_string_literal: true

describe NotificationsController do
  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :index, params: {}]
    ]
  end

  describe 'GET index' do
    subject { get(:index, format: :json) }

    let(:user) { create(:user) }

    before { sign_in(user) }

    context 'without notifications' do
      it do
        expect(subject).to render_template(:index)
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'with read notifications' do
      let(:announcement) { create(:announcement) }
      let!(:notification) do
        create(:notification, recipient: user, notifiable: announcement)
      end

      it do
        expect(subject).to render_template(:index)
        expect(response).to be_successful
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'with unread notifications' do
      let(:user_b) { create(:user) }

      let(:announcement) { create(:announcement) }
      let!(:notification) do
        create(:notification, :unread, recipient: user, notifiable: announcement)
      end
      let!(:notification_b) do
        create(:notification, :unread, recipient: user_b, notifiable: announcement)
      end

      let(:expected_response) do
        [
          {
            'id' => notification.id,
            'template' =>
              "<div class='dropdown-item text-sm text-muted'>\n" \
              "<i>Mambo jambo</i>\n</div>\n"
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
end
