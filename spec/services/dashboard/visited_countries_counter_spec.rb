# frozen_string_literal: true

describe Dashboard::VisitedCountriesCounter do
  let(:counter) { described_class.new(user) }
  let(:user) { create(:user) }

  let(:european_country) { create(:country) }
  let(:asian_country) { create(:country, :asian) }
  let(:oceanian_country) { create(:country, :oceanian) }
  let(:african_country) { create(:country, :african) }
  let(:antarctic_country) { create(:country, :antarctican) }
  let(:north_american_country) { create(:country, :north_american) }
  let(:central_american_country) { create(:country, :central_american) }
  let(:caribbean_country) { create(:country, :caribbean) }
  let(:south_american_country) { create(:country, :south_american) }
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

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) do
      [
        'dashboard/visited_countries_counter',
        method_name,
        user.cache_key
      ].join('/')
    end

    it do
      expect(Rails).to receive(:cache).and_return(cache)
      expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
      subject
    end
  end

  describe '#to_a' do
    subject { counter.to_a }

    let(:european_country_b) { create(:country) }
    let(:european_country_c) { create(:country) }
    let(:african_country_b) { create(:country, :african) }

    let(:european_checkin_b) do
      create(:checkin, user: user, country: european_country_b)
    end
    let(:european_checkin_c) do
      create(:checkin, user: user, country: european_country_c)
    end
    let(:african_checkin_b) do
      create(:checkin, user: user, country: african_country_b)
    end

    before do
      european_checkin
      asian_checkin
      african_checkin
      south_american_checkin
      european_checkin_b
      european_checkin_c
      african_checkin_b
    end

    it_behaves_like 'with cached method' do
      let(:method_name) { 'to_a' }
    end

    it { is_expected.to eq([['CH', 3], ['CN', 1], ['MG', 2], ['PE', 1]]) }
  end

  describe '#countries_count' do
    subject { counter.countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'countries_count' }
    end

    context 'when world checkin exist' do
      before do
        european_checkin
        asian_checkin
        african_checkin
      end

      it { is_expected.to eq(3) }

      context 'with two same countries' do
        let!(:european_checkin_b) do
          create(:checkin, user: user, country: european_country)
        end

        it { is_expected.to eq(3) }
      end
    end

    context 'when world checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#european_countries_count' do
    subject { counter.european_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'european_countries_count' }
    end

    context 'when european checkin exist' do
      before { european_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:european_checkin_b) do
          create(:checkin, user: user, country: european_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:european_country_b) { create(:country) }
        let!(:european_checkin_b) do
          create(:checkin, user: user, country: european_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when european checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#north_american_countries_count' do
    subject { counter.north_american_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'north_american_countries_count' }
    end

    context 'when north american checkin exist' do
      before { north_american_checkin }

      it { is_expected.to eq(1) }

      context 'with central american country' do
        let(:central_american_checkin) do
          create(:checkin, user: user, country: central_american_country)
        end

        before { central_american_checkin }

        it { is_expected.to eq(2) }
      end

      context 'with caribbean country' do
        let(:caribbean_checkin) do
          create(:checkin, user: user, country: caribbean_country)
        end

        before { caribbean_checkin }

        it { is_expected.to eq(2) }
      end

      context 'with two same countries' do
        let!(:north_american_checkin_b) do
          create(:checkin, user: user, country: north_american_country)
        end

        it { is_expected.to eq(1) }
      end
    end

    context 'when north american checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#south_american_countries_count' do
    subject { counter.south_american_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'south_american_countries_count' }
    end

    context 'when south american checkin exist' do
      before { south_american_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:south_american_checkin_b) do
          create(:checkin, user: user, country: south_american_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:south_american_country_b) { create(:country, :south_american) }
        let!(:south_american_checkin_b) do
          create(:checkin, user: user, country: south_american_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when south american checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#asian_countries_count' do
    subject { counter.asian_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'asian_countries_count' }
    end

    context 'when asian checkin exist' do
      before { asian_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:asian_checkin_b) do
          create(:checkin, user: user, country: asian_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:asian_country_b) { create(:country, :asian) }
        let!(:asian_checkin_b) do
          create(:checkin, user: user, country: asian_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when asian checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#oceanian_countries_count' do
    subject { counter.oceanian_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'oceanian_countries_count' }
    end

    context 'when oceanian checkin exist' do
      before { oceanian_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:oceanian_checkin_b) do
          create(:checkin, user: user, country: oceanian_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:oceanian_country_b) { create(:country, :oceanian) }
        let!(:oceanian_checkin_b) do
          create(:checkin, user: user, country: oceanian_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when oceanian checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#african_countries_count' do
    subject { counter.african_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'african_countries_count' }
    end

    context 'when african checkin exist' do
      before { african_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:african_checkin_b) do
          create(:checkin, user: user, country: african_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:african_country_b) { create(:country, :african) }
        let!(:african_checkin_b) do
          create(:checkin, user: user, country: african_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when african checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#antarctican_countries_count' do
    subject { counter.antarctican_countries_count }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'antarctican_countries_count' }
    end

    context 'when antarctic checkin exist' do
      before { antarctic_checkin }

      it { is_expected.to eq(1) }

      context 'with two same countries' do
        let!(:antarctic_checkin_b) do
          create(:checkin, user: user, country: antarctic_country)
        end

        it { is_expected.to eq(1) }
      end

      context 'with other country' do
        let(:antarctican_country_b) { create(:country, :antarctican) }
        let!(:antarctican_checkin_b) do
          create(:checkin, user: user, country: antarctican_country_b)
        end

        it { is_expected.to eq(2) }
      end
    end

    context 'when antarctic checkin does not exist' do
      it { is_expected.to eq(0) }
    end
  end

  describe '#cache_key' do
    subject(:cache_key) do
      counter.send(:cache_key, 'european_countries_count')
    end

    before { european_checkin }

    it do
      expect(cache_key).to eq(
        'dashboard/visited_countries_counter/european_countries_count/' \
        "#{user.cache_key}"
      )
    end
  end
end
