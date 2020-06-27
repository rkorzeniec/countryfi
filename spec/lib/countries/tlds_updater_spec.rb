# frozen_string_literal: true

describe Countries::TldsUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) { %w[.ch .com] }

  it { expect(described_class::LOG_COLUMNS).to eq(%w[country_id name]) }

  describe '#call' do
    subject { updater.call }

    let!(:language) { create(:top_level_domain, country: country, name: '.ch') }

    it 'updates records' do
      expect(Rails.logger).to receive(:info).twice.with(/TopLevelDomain/)
      expect(TopLevelDomain).to receive(:find_or_create_by)
        .twice
        .and_call_original

      expect { subject }.to change { country.top_level_domains.count }
        .from(1).to(2)

      language = TopLevelDomain.first
      expect(language.name).to eq('.ch')

      language = TopLevelDomain.last
      expect(language.name).to eq('.com')
    end
  end
end
