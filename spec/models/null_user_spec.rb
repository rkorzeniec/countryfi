# frozen_string_literal: true

describe NullUser do
  let(:user) { described_class.new }

  describe '#unread_notifications' do
    subject { user.unread_notifications }

    it { is_expected.to be_empty }
    it { expect(subject.exists?).to be_falsey }
  end
end
