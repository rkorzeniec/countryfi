describe Country do
  it { is_expected.to have_many(:checkins).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:currencies).dependent(:restrict_with_error) }
  it do
    is_expected.to have_many(:top_level_domains).dependent(:restrict_with_error)
  end
  it { is_expected.to have_many(:country_languages).dependent(:destroy) }
  it { is_expected.to have_many(:country_calling_codes).dependent(:destroy) }
  it { is_expected.to have_many(:border_countries).dependent(:destroy) }
  it do
    is_expected.to have_many(:country_alternative_spellings).dependent(:destroy)
  end

  describe '.find_by_any' do
    let(:switzerland) { create(:country) }
    let(:united_states) do
      create(
        :country,
        name_common: 'United States', name_official: 'United States of America',
        cca2: 'US', ccn3: '840', cca3: 'USA', cioc: 'USA'
      )
    end

    before do
      united_states
      switzerland
    end

    subject { described_class.find_by_any(name) }

    context 'when name is cca2' do
      let(:name) { 'CH' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is ccn3' do
      let(:name) { 756 }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is cca3' do
      let(:name) { 'CHE' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is cioc' do
      let(:name) { 'SUI' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is neither' do
      let(:name) { nil }

      it { expect(subject).to eq(Country.first) }
    end
  end

  describe '#european' do
    it do
      expect { create(:country) }.to change { Country.european.count }
        .from(0).to(1)
    end

    it do
      expect { create(:country, :asian) }
        .not_to change { Country.european.count }
    end
  end

  describe '#asian' do
    it do
      expect { create(:country, :asian) }.to change {
        Country.asian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.asian.count }
    end
  end

  describe '#african' do
    it do
      expect { create(:country, :african) }.to change {
        Country.african.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.african.count }
    end
  end

  describe '#antarctican' do
    it do
      expect { create(:country, :antarctican) }.to change {
        Country.antarctican.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.antarctican.count }
    end
  end

  describe '#oceanian' do
    it do
      expect { create(:country, :oceanian) }.to change {
        Country.oceanian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.oceanian.count }
    end
  end

  describe '#north_american' do
    it do
      expect { create(:country, :north_american) }.to change {
        Country.north_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.north_american.count }
    end
  end

  describe '#south_american' do
    it do
      expect { create(:country, :south_american) }.to change {
        Country.south_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change { Country.south_american.count }
    end
  end

  describe '#flag_image_path' do
    subject { country.flag_image_path }

    context 'when flag does not exist' do
      let(:country) { build_stubbed(:country, cca2: 'mambo') }

      it do
        is_expected.to eq(
          ActionController::Base.helpers.asset_path('flags/unknown.png')
        )
      end
    end

    context 'when flag exist' do
      let(:country) { build_stubbed(:country, cca2: 'ch') }

      it { is_expected.to eq('/images/flags/ch.png') }
    end
  end
end
