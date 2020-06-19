# frozen_string_literal: true

describe TopRegionsQuery do
  let!(:query) { described_class.new(user.visited_countries) }

  describe '#query' do
    subject { query.query }

    let(:user) { create(:user) }

    let!(:european_country) { create(:country) }
    let!(:european_checkins) do
      create_list(:checkin, 2, user: user, country: european_country)
    end

    let!(:african_country) { create(:country, :african) }
    let!(:african_checkins) do
      create_list(:checkin, 3, user: user, country: african_country)
    end

    let!(:asian_country) { create(:country, :asian) }
    let!(:asian_checkins) do
      create_list(:checkin, 4, user: user, country: asian_country)
    end

    let!(:antarctican_country) { create(:country, :antarctican) }
    let!(:antarctican_checkins) do
      create(:checkin, user: user, country: antarctican_country)
    end

    let!(:oceanian_country) { create(:country, :oceanian) }
    let!(:oceanian_checkins) do
      create(:checkin, user: user, country: oceanian_country)
    end

    let!(:north_american_country) { create(:country, :north_american) }
    let!(:north_american_checkins) do
      create(:checkin, user: user, country: north_american_country)
    end

    let!(:caribbean_country) { create(:country, :caribbean) }
    let!(:caribbean_checkins) do
      create(:checkin, user: user, country: caribbean_country)
    end

    let!(:south_american_country) { create(:country, :south_american) }
    let!(:south_american_checkins) do
      create(:checkin, user: user, country: south_american_country)
    end

    it do
      is_expected.to eq(
        {
          'Antarctica' => 1,
          'Australia and New Zealand' => 1,
          'Caribbean' => 1,
          'Western Europe' => 2,
          'Eastern Asia' => 4,
          'Northern America' => 1,
          'Eastern Africa' => 3
        }
      )
    end
  end
end
