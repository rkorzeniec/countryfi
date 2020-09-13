# frozen_string_literal: true

describe VisitedCountriesQuery do
  let(:user) { create(:user) }
  let(:now) { Time.zone.local(2017, 10, 9) }
  let(:query) { described_class.new(user) }

  before { Timecop.freeze(now) }

  after { Timecop.return }

  describe '#count_by_year' do
    subject { query.count_by_year }

    let(:cache) { instance_double('cache') }

    context 'with already visited countries' do
      let(:country) { create(:country, independent: true, un_member: true) }
      let(:country_b) { create(:country, independent: true, un_member: false) }
      let(:country_c) { create(:country, independent: false, un_member: true) }

      let!(:checkin) do
        create(:checkin, user: user, country: country, checkin_date: now - 1.day)
      end
      let!(:checkin_b) do
        create(:checkin, user: user, country: country, checkin_date: now - 1.month)
      end
      let!(:checkin_c) do
        create(:checkin, user: user, country: country, checkin_date: now - 1.year)
      end
      let!(:checkin_d) do
        create(:checkin, user: user, country: country_b, checkin_date: now + 1.day)
      end
      let!(:checkin_e) do
        create(:checkin, user: user, country: country_b, checkin_date: now - 5.years)
      end
      let!(:checkin_f) do
        create(:checkin, user: user, country: country_c, checkin_date: now - 1.year)
      end

      let(:cache_key) do
        ['visited_countries_query', user.id, checkin_f.id].join('/')
      end

      it { is_expected.to eq(2012 => 1, 2016 => 2, 2017 => 2) }

      it do
        expect(Rails).to receive(:cache).and_return(cache)
        expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
        subject
      end

      context 'with independent' do
        let(:user) { create(:user, countries_cluster: 'independent') }

        it { is_expected.to eq(2012 => 1, 2016 => 1, 2017 => 2) }
      end

      context 'with un member' do
        let(:user) { create(:user, countries_cluster: 'un_member') }

        it { is_expected.to eq(2016 => 2, 2017 => 2) }
      end
    end

    context 'with not visited countries' do
      let!(:checkin) do
        create(:checkin, user: user, checkin_date: now + 1.day)
      end
      let(:cache_key) do
        ['visited_countries_query', user.id].compact.join('/')
      end

      it { is_expected.to be_empty }

      it do
        expect(Rails).to receive(:cache).and_return(cache)
        expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
        subject
      end
    end
  end
end
