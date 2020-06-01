# frozen_string_literal: true
describe UnvisitedCountriesQuery do
  let(:params) { {} }
  let(:query) { described_class.new(visited, params) }

  describe '#all' do
    context 'with prefix' do
      subject { query.all }

      let!(:country) { create(:country) }
      let!(:country_b) { create(:country, :asian) }
      let!(:country_c) { create(:country, :south_american) }
      let!(:country_d) { create(:country, :caribbean) }

      context 'with visited' do
        let(:visited) { [country] }

        it { is_expected.to eq([country_b, country_d, country_c]) }

        context 'with region' do
          let(:params) { { regions: 'Asia' } }

          it { is_expected.to eq([country_b]) }

          context 'with subregion' do
            let(:params) { { regions: 'Americas', subregions: 'Caribbean' } }

            it { is_expected.to eq([country_d]) }
          end

          context 'with subregions' do
            let(:params) do
              { regions: 'Americas', subregions: ['Caribbean', 'South America'] }
            end

            it { is_expected.to eq([country_d, country_c]) }
          end
        end
      end

      context 'without visited' do
        let(:visited) { [] }

        it { is_expected.to eq([country_b, country_d, country_c, country]) }

        context 'with region' do
          let(:params) { { regions: 'Asia' } }

          it { is_expected.to eq([country_b]) }

          context 'with subregion' do
            let(:params) { { regions: 'Americas', subregions: 'Caribbean' } }

            it { is_expected.to eq([country_d]) }
          end

          context 'with subregions' do
            let(:params) do
              { regions: 'Americas', subregions: ['Caribbean', 'South America'] }
            end

            it { is_expected.to eq([country_d, country_c]) }
          end
        end
      end
    end
  end
end
