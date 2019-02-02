describe ExploreFacade do
  let(:region) { 'north_america' }
  let(:subregion) { 'carribean' }
  let(:facade) do
    described_class.new(
      visited_countries, region: region, subregions: subregion
    )
  end

  describe '#discoverable_countries' do
    subject { facade.discoverable_countries('B') }

    context 'when no visited countries' do
      let(:visited_countries) { nil }

      it { is_expected.to be_empty }
      it do
        expect(UnvisitedCountriesQuery).to receive(:new)
          .with([], regions: region, subregions: subregion)
          .and_call_original
        expect_any_instance_of(UnvisitedCountriesQuery)
          .to receive(:countries_by)
          .with('B')
          .and_call_original
        subject
      end
    end

    context 'when visited countries' do
      let!(:country) { create(:country) }
      let(:visited_countries) { [country] }

      it do
        expect(UnvisitedCountriesQuery).to receive(:new)
          .with([country.id], regions: region, subregions: subregion)
          .and_call_original
        expect_any_instance_of(UnvisitedCountriesQuery)
          .to receive(:countries_by)
          .with('B')
          .and_call_original
        subject
      end
    end
  end
end
