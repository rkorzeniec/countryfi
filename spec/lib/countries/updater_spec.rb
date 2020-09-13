# frozen_string_literal: true

describe Countries::Updater do
  let(:updater) { described_class.new(data) }
  let(:data) do
    YAML.load_file(
      Rails.root.join('spec/support/fixtures/countries_data.yml')
    )[0]
  end

  it do
    expect(described_class::LOG_COLUMNS).to eq(
      %w[
        name_common name_official cca2 ccn3 cca3 cioc un_member independent status
        capital region subregion latitude longitude area demonym flag
      ]
    )
  end

  describe '#call' do
    subject { updater.call }

    context 'with existing country' do
      let!(:country) do
        create(
          :country,
          ccn3: '123',
          cioc: nil,
          un_member: false,
          independent: true,
          demonym: '',
          subregion: 'Southern Europe'
        )
      end

      it 'updates records' do
        expect(Country).to receive(:find_or_create_by).exactly(6).times
          .and_call_original

        expect(Countries::TldsUpdater).to receive(:new)
          .with(country: country, data: ['.ch'])
          .and_call_original

        expect(Countries::CurrenciesUpdater).to receive(:new)
          .with(
            country: country,
            data: { 'CHF' => { 'name' => 'Swiss franc', 'symbol' => 'Fr.' } }
          ).and_call_original

        expect(Countries::CallingCodesUpdater).to receive(:new)
          .with(country: country, data: ['+41'])
          .and_call_original

        expect(Countries::AltSpellingsUpdater).to receive(:new)
          .with(
            country: country,
            data: [
              'CH', 'Swiss Confederation', 'Schweiz', 'Suisse', 'Svizzera',
              'Svizra'
            ]
          ).and_call_original

        expect(Countries::LanguagesUpdater).to receive(:new)
          .with(
            country: country,
            data: {
              'fra' => 'French',
              'gsw' => 'Swiss German',
              'ita' => 'Italian',
              'roh' => 'Romansh'
            }
          ).and_call_original

        expect(Countries::BordersUpdater).to receive(:new)
          .with(
            country: country,
            data: %w[AUT FRA ITA LIE DEU]
          ).and_call_original

        expect { subject }.to change { country.reload.ccn3 }
          .from('123').to('756')
          .and change { country.un_member }.from(false).to(true)
          .and change { country.independent }.from(true).to(false)
          .and change { country.cioc }.from(nil).to('SUI')
          .and change { country.subregion }
          .from('Southern Europe').to('Western Europe')
          .and change { country.demonym }
          .from('').to('Swiss')
      end
    end

    context 'with new country' do
      it 'creates records' do
        expect(Country).to receive(:find_or_create_by).exactly(6).times
          .and_call_original

        expect(Countries::TldsUpdater).to receive(:new)
          .with(country: a_kind_of(Country), data: ['.ch'])
          .and_call_original

        expect(Countries::CurrenciesUpdater).to receive(:new)
          .with(
            country: a_kind_of(Country),
            data: { 'CHF' => { 'name' => 'Swiss franc', 'symbol' => 'Fr.' } }
          ).and_call_original

        expect(Countries::CallingCodesUpdater).to receive(:new)
          .with(country: a_kind_of(Country), data: ['+41'])
          .and_call_original

        expect(Countries::AltSpellingsUpdater).to receive(:new)
          .with(
            country: a_kind_of(Country),
            data: [
              'CH', 'Swiss Confederation', 'Schweiz', 'Suisse', 'Svizzera',
              'Svizra'
            ]
          ).and_call_original

        expect(Countries::LanguagesUpdater).to receive(:new)
          .with(
            country: a_kind_of(Country),
            data: {
              'fra' => 'French',
              'gsw' => 'Swiss German',
              'ita' => 'Italian',
              'roh' => 'Romansh'
            }
          ).and_call_original

        expect(Countries::BordersUpdater).to receive(:new)
          .with(
            country: a_kind_of(Country),
            data: %w[AUT FRA ITA LIE DEU]
          ).and_call_original

        expect { subject }.to change { Country.count }.from(0).to(6)
      end
    end
  end
end
