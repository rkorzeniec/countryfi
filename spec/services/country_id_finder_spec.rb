# frozen_string_literal: true

describe CountryIdFinder do
  describe '.lookup' do
    subject { described_class.lookup(code) }

    let!(:country) { create(:country) }

    context 'when country exists' do
      let(:code) { 'CH' }

      it { expect(subject).to eq(country.id) }
    end

    context 'when country does not exist' do
      let(:code) { 'XY' }

      it { expect(subject).to be_nil }
    end
  end
end
