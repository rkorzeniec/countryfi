describe CountriesHelper do
  describe '#country_code_array' do
    let(:country_a) { double(:country, cca2: 'AA') }
    let(:country_b) { double(:country, cca2: 'BB') }
    let(:countries) { [country_a, country_b] }

    subject { helper.country_code_array(countries) }

    it { expect(subject).to eq(['AA', 'BB']) }
  end
end
