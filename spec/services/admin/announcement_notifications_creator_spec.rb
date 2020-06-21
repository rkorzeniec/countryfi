# frozen_string_literal: true

describe Admin::AnnouncementNotificationsCreator do
  describe '#call' do
    subject { described_class.new(announcement).call }

    let(:announcement) { create(:announcement) }
    let(:notification_1) do
      {
        recipient_id: 1,
        notifiable_id: announcement.id,
        notifiable_type: Announcement
      }
    end
    let(:notification_2) do
      {
        recipient_id: 2,
        notifiable_id: announcement.id,
        notifiable_type: Announcement
      }
    end
    let(:notification_3) do
      {
        recipient_id: 3,
        notifiable_id: announcement.id,
        notifiable_type: Announcement
      }
    end

    before { expect(User).to receive(:ids).and_return([1, 2, 3]) }

    it do
      expect(Notification).to receive(:insert_all).with(
        [notification_1, notification_2, notification_3]
      ).and_call_original

      expect { subject }.to change { Notification.count }.from(0).to(3)
    end
  end
end
