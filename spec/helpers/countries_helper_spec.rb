describe CountriesHelper do
  describe '#visit_label' do
    subject { helper.visit_label(country) }

    let(:countries) { [] }
    let(:visited_countries) { [] }
    let(:country) { instance_double(Country) }
    let(:user) do
      instance_double(
        User,
        countries: countries,
        visited_countries: visited_countries
      )
    end

    before { allow(helper).to receive(:current_user).and_return(user) }

    context 'when country is not visited nor upcoming' do
      it { is_expected.to be_nil }
    end

    context 'when country is visited' do
      let(:countries) { [country] }
      let(:visited_countries) { [country] }

      it do
        expect(subject).to eq('<span class="label label-success">visited</span>')
      end
    end

    context 'when country is upcoming' do
      let(:countries) { [country] }

      it do
        expect(subject).to eq('<span class="label label-info">upcoming</span>')
      end
    end
  end
end
