describe CountryIDLookuper do
  describe '.lookup' do
    let!(:country) { create(:country) }

    subject { described_class.lookup(code) }

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
