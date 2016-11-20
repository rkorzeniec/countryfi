describe CountriesCounter do
  let!(:european_country) { create(:country, region: 'Europe') }
  let!(:asian_country) { create(:country, region: 'Asia') }
  let!(:oceanian_country) { create(:country, region: 'Oceania') }
  let!(:african_country) { create(:country, region: 'Africa') }
  let!(:north_american_country) do
    create(:country, region: 'Americas', subregion: 'North America')
  end
  let!(:south_american_country) do
    create(:country, region: 'Americas', subregion: 'South America')
  end

  describe '.european_countries_count' do
    subject { described_class.european_countries_count }

    it { expect(subject).to eq(1) }
  end

  describe '.north_american_countries_count' do
    subject { described_class.north_american_countries_count }

    it { expect(subject).to eq(1) }

    context 'with central american country' do
      let!(:central_american_country) do
        create(:country, region: 'Americas', subregion: 'Central America')
      end

      it { expect(subject).to eq(2) }
    end

    context 'with caribbean country' do
      let!(:caribbean_country) do
        create(:country, region: 'Americas', subregion: 'Caribbean')
      end

      it { expect(subject).to eq(2) }
    end
  end

  describe '.south_american_countries_count' do
    subject { described_class.south_american_countries_count }

    it { expect(subject).to eq(1) }
  end

  describe '.asian_countries_count' do
    subject { described_class.asian_countries_count }

    it { expect(subject).to eq(1) }
  end

  describe '.oceanian_countries_count' do
    subject { described_class.oceanian_countries_count }

    it { expect(subject).to eq(1) }
  end

  describe '.african_countries_count' do
    subject { described_class.african_countries_count }

    it { expect(subject).to eq(1) }
  end
end
