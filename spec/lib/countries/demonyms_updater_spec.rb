# frozen_string_literal: true

describe Countries::DemonymsUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:country) { create(:country) }
  let(:data) do
    {
      eng: { f: 'Swiss', m: 'Swiss' },
      fra: { f: 'Suisse', m: 'Suisse' }
    }
  end

  it do
    expect(described_class::LOG_COLUMNS).to eq(%w[country_id locale gender name])
  end

  describe '#call' do
    subject { updater.call }

    let!(:currency) do
      create(:demonym, country: country, locale: 'eng', gender: 'f')
    end

    it 'updates records' do
      expect(Rails.logger).to receive(:info).exactly(4).times.with(/Demonym/)
      expect(Demonym).to receive(:find_or_create_by)
        .exactly(4).times
        .and_call_original

      expect { subject }.to change { country.demonyms.count }
        .from(1).to(4)

      demonym = Demonym.first
      expect(demonym.locale).to eq('eng')
      expect(demonym.gender).to eq('f')
      expect(demonym.name).to eq('Swiss')

      demonym = Demonym.second
      expect(demonym.locale).to eq('eng')
      expect(demonym.gender).to eq('m')
      expect(demonym.name).to eq('Swiss')

      demonym = Demonym.third
      expect(demonym.locale).to eq('fra')
      expect(demonym.gender).to eq('f')
      expect(demonym.name).to eq('Suisse')

      demonym = Demonym.fourth
      expect(demonym.locale).to eq('fra')
      expect(demonym.gender).to eq('m')
      expect(demonym.name).to eq('Suisse')
    end
  end
end
