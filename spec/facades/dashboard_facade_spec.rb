describe DashboardFacade do
  let(:user) { build_stubbed(:user) }
  let(:facade) { described_class.new(user) }

  describe '#country_id' do
    let(:country_a) { double(:country, id: 1) }
    let(:country_b) { double(:country, id: 2) }
    let(:countries) { [country_a, country_b] }

    subject { facade.country_id(1) }

    before do
      allow(facade).to receive(:countries).and_return(countries)
    end

    it { expect(subject).to eq(country_b.id) }
  end

  %i[
    european north_american south_american asian african oceanian antarctican
  ].each do |region|
    describe "##{region}_country_id" do
      let(:index) { 1 }
      let(:country_a) { double(:country, id: 1) }
      let(:country_b) { double(:country, id: 2) }
      let(:countries) { double('relation') }

      subject { facade.send("#{region}_country_id".to_sym, index) }

      before do
        allow(countries).to receive(region).and_return([country_a, country_b])
        allow(facade).to receive(:countries).and_return(countries)
      end

      it { expect(subject).to eq(country_b.id) }

      context 'when country with index non existent' do
        let(:index) { 3 }

        it { expect(subject).to be_nil }
      end
    end
  end

  describe '#country_code_array' do
    let(:country_a) { build_stubbed(:country, cca2: 'AA') }
    let(:country_b) { build_stubbed(:country, cca2: 'BB') }
    let(:countries) { [country_a, country_b] }

    subject { facade.country_code_array }

    before do
      allow(facade).to receive(:visited_countries).and_return(countries)
    end

    it { expect(subject).to eq(%w[AA BB]) }
  end
end
