# frozen_string_literal: true

FactoryBot.define do
  factory :plain_notification, class: Notification do
    notifiable_id { 1 }
    notifiable_type { 'Announcement' }
    recipient_id { 1 }
    read_at { Time.current }
  end

  factory :notification do
    association :notifiable, factory: :announcement, strategy: :build
    association :recipient, factory: :user, strategy: :build
    read_at { Time.current }

    trait :unread do
      read_at { nil }
    end
  end
end
