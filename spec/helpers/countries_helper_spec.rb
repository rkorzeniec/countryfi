describe CountriesHelper do
  describe '#visit_label' do
    let(:countries) { [] }
    let(:visited_countries) { [] }
    let(:country) { double(:country) }
    let(:user) do
      double(:user, countries: countries, visited_countries: visited_countries)
    end

    subject { helper.visit_label(user, country) }

    context 'when country is not visited nor upcoming' do
      it { is_expected.to be_nil }
    end

    context 'when country is visited' do
      let(:countries) { [country] }
      let(:visited_countries) { [country] }

      it do
        is_expected.to eq('<span class="label label-success">visited</span>')
      end
    end

    context 'when country is upcoming' do
      let(:countries) { [country] }

      it do
        is_expected.to eq('<span class="label label-info">upcoming</span>')
      end
    end
  end
end
