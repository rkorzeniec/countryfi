# frozen_string_literal: true

describe Countries::CurrenciesUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) do
    {
      CHF: { name: 'Swiss franc', symbol: 'Fr.' },
      AWG: { name: 'Aruban florin', symbol: 'ƒ' }
    }
  end

  it do
    expect(described_class::LOG_COLUMNS).to eq(%w[country_id code name symbol])
  end

  describe '#call' do
    subject { updater.call }

    let!(:currency) { create(:currency, country: country, code: 'CHF') }

    it 'updates records' do
      expect(Rails.logger).to receive(:info).twice.with(/Currency/)
      expect(Currency).to receive(:find_or_create_by)
        .twice
        .and_call_original

      expect { subject }.to change { country.currencies.count }
        .from(1).to(2)

      currency = Currency.first
      expect(currency.code).to eq('CHF')
      expect(currency.name).to eq('Swiss franc')
      expect(currency.symbol).to eq('Fr.')

      currency = Currency.last
      expect(currency.code).to eq('AWG')
      expect(currency.name).to eq('Aruban florin')
      expect(currency.symbol).to eq('ƒ')
    end
  end
end
