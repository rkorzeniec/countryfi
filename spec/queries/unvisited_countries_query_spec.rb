# frozen_string_literal: true

describe UnvisitedCountriesQuery do
  let(:params) { { user: user } }
  let(:query) { described_class.new(**params) }

  describe '#all' do
    context 'with prefix' do
      subject { query.all }

      let!(:country) { create(:country, independent: true, un_member: true) }
      let!(:country_b) do
        create(:country, :asian, independent: false, un_member: false)
      end
      let!(:country_c) do
        create(:country, :south_american, independent: true, un_member: false)
      end
      let!(:country_d) do
        create(:country, :caribbean, independent: false, un_member: true)
      end
      let!(:country_e) do
        create(:country, :oceanian, independent: true, un_member: true)
      end

      context 'with visited' do
        let(:user) do
          instance_double(
            User,
            countries: [country],
            independent_countries_preference?: false,
            un_countries_preference?: false
          )
        end

        it { is_expected.to eq([country_e, country_b, country_d, country_c]) }

        context 'with region' do
          let(:params) { { user: user, regions: 'Asia' } }

          it { is_expected.to eq([country_b]) }

          context 'with subregion' do
            let(:params) do
              { user: user, regions: 'Americas', subregions: 'Caribbean' }
            end

            it { is_expected.to eq([country_d]) }
          end

          context 'with subregions' do
            let(:params) do
              {
                user: user,
                regions: 'Americas',
                subregions: ['Caribbean', 'South America']
              }
            end

            it { is_expected.to eq([country_d, country_c]) }
          end
        end

        context 'with independent countries' do
          let(:user) do
            instance_double(
              User,
              countries: [country],
              independent_countries_preference?: true,
              un_countries_preference?: false
            )
          end

          it { is_expected.to eq([country_e, country_c]) }
        end

        context 'with un countries' do
          let(:user) do
            instance_double(
              User,
              countries: [country],
              independent_countries_preference?: false,
              un_countries_preference?: true
            )
          end

          it { is_expected.to eq([country_e, country_d]) }
        end
      end

      context 'without visited' do
        let(:user) do
          instance_double(
            User,
            countries: [],
            independent_countries_preference?: false,
            un_countries_preference?: false
          )
        end

        it do
          is_expected.to eq([country_e, country_b, country_d, country_c, country])
        end

        context 'with region' do
          let(:params) { { user: user, regions: 'Asia' } }

          it { is_expected.to eq([country_b]) }

          context 'with subregion' do
            let(:params) do
              { user: user, regions: 'Americas', subregions: 'Caribbean' }
            end

            it { is_expected.to eq([country_d]) }
          end

          context 'with subregions' do
            let(:params) do
              {
                user: user,
                regions: 'Americas',
                subregions: ['Caribbean', 'South America']
              }
            end

            it { is_expected.to eq([country_d, country_c]) }
          end
        end

        context 'with independent countries' do
          let(:user) do
            instance_double(
              User,
              countries: [],
              independent_countries_preference?: true,
              un_countries_preference?: false
            )
          end

          it { is_expected.to eq([country_e, country_c, country]) }
        end

        context 'with un countries' do
          let(:user) do
            instance_double(
              User,
              countries: [],
              independent_countries_preference?: false,
              un_countries_preference?: true
            )
          end

          it { is_expected.to eq([country_e, country_d, country]) }
        end
      end
    end
  end
end
