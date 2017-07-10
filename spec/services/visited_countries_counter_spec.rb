describe VisitedCountriesCounter do
  let(:counter) { described_class.new(user) }
  let(:user) { create(:user) }

  let(:european_country) { create(:country, region: 'Europe') }
  let(:asian_country) { create(:country, region: 'Asia') }
  let(:oceanian_country) { create(:country, region: 'Oceania') }
  let(:african_country) { create(:country, region: 'Africa') }
  let(:antarctic_country) { create(:country, region: 'Antarctica') }
  let(:north_american_country) do
    create(:country, region: 'Americas', subregion: 'Northern America')
  end
  let(:central_american_country) do
    create(:country, region: 'Americas', subregion: 'Central America')
  end
  let(:caribbean_country) do
    create(:country, region: 'Americas', subregion: 'Caribbean')
  end
  let(:south_american_country) do
    create(:country, region: 'Americas', subregion: 'South America')
  end
  let(:european_checkin) do
    create(:checkin, user: user, country: european_country)
  end
  let(:north_american_checkin) do
    create(:checkin, user: user, country: north_american_country)
  end
  let(:south_american_checkin) do
    create(:checkin, user: user, country: south_american_country)
  end
  let(:asian_checkin) do
    create(:checkin, user: user, country: asian_country)
  end
  let(:african_checkin) do
    create(:checkin, user: user, country: african_country)
  end
  let(:oceanian_checkin) do
    create(:checkin, user: user, country: oceanian_country)
  end
  let(:antarctic_checkin) do
    create(:checkin, user: user, country: antarctic_country)
  end

  describe '#visited_world_countries_count' do
    subject { counter.visited_world_countries_count }

    context 'when world checkin exist' do
      before do
        european_checkin
        asian_checkin
        african_checkin
      end

      it { expect(subject).to eq(3) }
    end

    context 'when world checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_european_countries_count' do
    subject { counter.visited_european_countries_count }

    context 'when european checkin exist' do
      before { european_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when european checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_north_american_countries_count' do
    subject { counter.visited_north_american_countries_count }

    context 'when north american checkin exist' do
      before { north_american_checkin }

      it { expect(subject).to eq(1) }

      context 'with central american country' do
        let(:central_american_country) do
          create(:country, region: 'Americas', subregion: 'Central America')
        end
        let(:central_american_checkin) do
          create(:checkin, user: user, country: central_american_country)
        end

        before { central_american_checkin }

        it { expect(subject).to eq(2) }
      end

      context 'with caribbean country' do
        let(:caribbean_country) do
          create(:country, region: 'Americas', subregion: 'Caribbean')
        end
        let(:caribbean_checkin) do
          create(:checkin, user: user, country: caribbean_country)
        end

        before { caribbean_checkin }

        it { expect(subject).to eq(2) }
      end
    end

    context 'when north american checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_south_american_countries_count' do
    subject { counter.visited_south_american_countries_count }

    context 'when south american checkin exist' do
      before { south_american_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when south american checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_asian_countries_count' do
    subject { counter.visited_asian_countries_count }

    context 'when asian checkin exist' do
      before { asian_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when asian checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_oceanian_countries_count' do
    subject { counter.visited_oceanian_countries_count }

    context 'when oceanian checkin exist' do
      before { oceanian_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when oceanian checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_african_countries_count' do
    subject { counter.visited_african_countries_count }

    context 'when african checkin exist' do
      before { african_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when african checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end

  describe '#visited_antarctican_countries_count' do
    subject { counter.visited_antarctican_countries_count }

    context 'when antarctic checkin exist' do
      before { antarctic_checkin }

      it { expect(subject).to eq(1) }
    end

    context 'when antarctic checkin does not exist' do
      it { expect(subject).to eq(0) }
    end
  end
end
