# frozen_string_literal: true

describe Current do
  let(:model) { described_class }

  describe '#user' do
    subject { described_class.user = user }

    let(:user) { build_stubbed(:user) }

    context 'when user is not set' do
      before { described_class.user = nil }

      after { described_class.user = nil }

      it do
        expect { subject }.to change { described_class.user }.from(nil).to(user)
      end
    end

    context 'when user is set' do
      before { described_class.user = user }

      after { described_class.user = nil }

      it do
        expect { subject }.not_to change { described_class.user }
      end
    end
  end
end
