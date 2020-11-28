# frozen_string_literal: true

describe PreferencesHelper do
  describe '#user_profile_switch_label' do
    subject { helper.user_profile_switch_label(user) }

    context 'when nil' do
      let(:user) { build_stubbed(:user, public_profile: nil) }

      it { is_expected.to eq('Profile: private') }
    end

    context 'when true' do
      let(:user) { build_stubbed(:user, public_profile: true) }

      it { is_expected.to eq('Profile: public') }
    end

    context 'when false' do
      let(:user) { build_stubbed(:user, public_profile: false) }

      it { is_expected.to eq('Profile: private') }
    end
  end

  describe '#user_profile' do
    subject { helper.user_profile(user) }

    let(:user) { build_stubbed(:user, profile: 'aabbcc') }

    it { is_expected.to eq('aabbcc') }

    context 'when nil' do
      let(:user) { build_stubbed(:user, profile: nil) }

      before do
        expect(SecureRandom).to receive(:alphanumeric)
          .with(8)
          .and_return('abcd1234')
      end

      it { is_expected.to eq('abcd1234') }
    end
  end

  describe '#countries_all?' do
    subject { helper.countries_all?(user) }

    context 'when nil' do
      let(:user) { build_stubbed(:user, countries_cluster: nil) }

      it { is_expected.to be true }
    end

    context 'when true' do
      let(:user) { build_stubbed(:user, countries_cluster: 'all') }

      it { is_expected.to be true }
    end

    context 'when false' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to be false }
    end
  end

  describe '#countries_independent?' do
    subject { helper.countries_independent?(user) }

    context 'when true' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to be true }
    end

    context 'when false' do
      let(:user) { build_stubbed(:user, countries_cluster: 'all') }

      it { is_expected.to be false }
    end
  end

  describe '#countries_un_member?' do
    subject { helper.countries_un_member?(user) }

    context 'when true' do
      let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }

      it { is_expected.to be true }
    end

    context 'when false' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it { is_expected.to be false }
    end
  end
end
