describe Country do
  it { is_expected.to have_many(:checkins) }
  it { is_expected.to have_many(:currencies) }
  it { is_expected.to have_many(:top_level_domains) }
  it { is_expected.to have_many(:country_languages) }
  it { is_expected.to have_many(:country_calling_codes) }
  it { is_expected.to have_many(:border_countries) }
  it { is_expected.to have_many(:country_alternative_spellings) }

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

      it { expect(subject).to be_nil }
    end
  end
end
