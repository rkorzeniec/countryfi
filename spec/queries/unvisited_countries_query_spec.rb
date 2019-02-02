describe UnvisitedCountriesQuery do
  let(:params) { {} }
  let(:query) { described_class.new(visited, params) }

  describe '#countries_by' do
    context 'with prefix' do
      let(:prefix) { 'S' }

      subject { query.countries_by(prefix) }

      context 'with visited' do
        let!(:country) { create(:country) }
        let!(:country_b) { create(:country, :asian) }
        let!(:country_c) { create(:country, :african) }

        context 'with region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end

        context 'without region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end
      end

      context 'without visited' do
        context 'with region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end

        context 'without region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end
      end
    end

    context 'without prefix' do
      subject { query.countries_by }

      context 'with visited' do
        context 'with region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end

        context 'without region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end
      end

      context 'without visited' do
        context 'with region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end

        context 'without region' do
          context 'with subregion' do

          end

          context 'with subregions' do

          end

          context 'without subregion' do

          end
        end
      end
    end
  end
end
