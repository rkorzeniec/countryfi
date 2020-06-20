# frozen_string_literal: true

describe Announcement do
  it { is_expected.to have_many(:announcement_notifications).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_length_of(:message).is_at_most(255) }
end
