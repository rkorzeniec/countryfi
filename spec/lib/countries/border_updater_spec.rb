# frozen_string_literal: true

describe Countries::BordersUpdater do
  let(:updater) { described_class.new(country: country, data: data) }
  let(:data) { %w[AUT FRA ITA LIE DEU] }

  it do
    expect(described_class::LOG_COLUMNS).to eq(
      %w[country_id border_country_id]
    )
  end

  describe '#call' do
    subject { updater.call }

    let!(:country) { create(:country) }
    let!(:neighbour_country) { create(:country, cca3: 'AUT') }
    let!(:border) do
      create(:border_country, country: country, border_country: neighbour_country)
    end

    it do
      expect { subject }.to change { Country.count }.from(2).to(6)
        .and change { BorderCountry.count }.from(1).to(5)
    end
  end
end
