# frozen_string_literal: true

describe Countries::AltSpellingsUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) do
    ['CH', 'Swiss Confederation', 'Schweiz', 'Suisse', 'Svizzera', 'Svizra']
  end

  it do
    expect(described_class::LOG_COLUMNS).to eq(%w[country_id name])
  end

  describe '#call' do
    subject { updater.call }

    let!(:alt_spelling) do
      create(:country_alternative_spelling, country: country, name: 'CH')
    end

    it 'updates records' do
      expect(Rails.logger).to receive(:info)
        .exactly(6)
        .with(/CountryAlternativeSpelling/)

      expect(CountryAlternativeSpelling).to receive(:find_or_create_by)
        .exactly(6).times
        .and_call_original

      expect { subject }.to change { country.country_alternative_spellings.count }
        .from(1).to(6)

      expect(country.country_alternative_spellings.map(&:name)).to eq(data)
    end
  end
end
