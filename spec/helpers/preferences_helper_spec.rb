# frozen_string_literal: true

describe PreferencesHelper do
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
