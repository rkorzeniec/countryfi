# frozen_string_literal: true

describe Countries::CallingCodesUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) { %w[+41 +297] }

  it do
    expect(described_class::LOG_COLUMNS).to eq(%w[country_id calling_code])
  end

  describe '#call' do
    subject { updater.call }

    let!(:calling_code) do
      create(:country_calling_code, country: country, calling_code: '+41')
    end

    it 'updates records' do
      expect(Rails.logger).to receive(:info).twice.with(/CountryCallingCode/)
      expect(CountryCallingCode).to receive(:find_or_create_by)
        .twice
        .and_call_original

      expect { subject }.to change { country.country_calling_codes.count }
        .from(1).to(2)

      calling_code = CountryCallingCode.first
      expect(calling_code.calling_code).to eq('+41')

      calling_code = CountryCallingCode.last
      expect(calling_code.calling_code).to eq('+297')
    end

    context 'without code' do
      let(:data) { [] }

      it do
        expect { subject }.not_to change { country.country_calling_codes.count }
      end
    end
  end
end
