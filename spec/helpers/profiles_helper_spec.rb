# frozen_string_literal: true

describe ProfilesHelper do
  describe '#can_show_profile?' do
    subject { helper.can_show_profile?(user) }

    context 'with public' do
      let(:user) { build_stubbed(:user, public_profile: true) }

      it { is_expected.to be true }
    end

    context 'when private' do
      let(:user) { build_stubbed(:user, public_profile: false) }

      context 'when current user' do
        before { allow(helper).to receive(:current_user).and_return(user) }

        it { is_expected.to be true }
      end

      context 'without different user' do
        let(:user_b) { build_stubbed(:user, public_profile: false) }

        before { allow(helper).to receive(:current_user).and_return(user_b) }

        it { is_expected.to be false }
      end

      context 'without current user' do
        before { allow(helper).to receive(:current_user).and_return(nil) }

        it { is_expected.to be false }
      end
    end
  end
end