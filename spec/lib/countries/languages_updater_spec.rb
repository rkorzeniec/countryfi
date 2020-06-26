# frozen_string_literal: true

describe Countries::LanguagesUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) { { eng: 'English', deu: 'German' } }

  it { expect(described_class::LOG_COLUMNS).to eq(%w[country_id name code]) }

  describe '#call' do
    subject { updater.call }

    let!(:language) { create(:country_language, country: country, code: 'eng') }

    it 'updates records' do
      expect(CountryLanguage).to receive(:find_or_create_by)
        .twice
        .and_call_original

      expect { subject }.to change { country.country_languages.count }
        .from(1).to(2)

      language = CountryLanguage.first
      expect(language.code).to eq('eng')
      expect(language.name).to eq('English')

      language = CountryLanguage.last
      expect(language.code).to eq('deu')
      expect(language.name).to eq('German')
    end
  end
end
