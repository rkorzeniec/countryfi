# frozen_string_literal: true

describe ExploresHelper do
  describe '#all_countries_category' do
    subject { helper.all_countries_category(category) }

    context 'with all category' do
      let(:category) { 'All' }

      it { is_expected.to be_truthy }
    end

    context 'when checkin not supplied' do
      let(:category) { 'A' }

      it { is_expected.to be_falsey }
    end
  end
end
