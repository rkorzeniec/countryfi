describe UniqVisitedCountriesQuery do
  let(:user) { create(:user) }
  let(:now) { Time.local(2017, 10, 9) }
  let(:query) { described_class.new(user) }

  before { Timecop.freeze(now) }
  after { Timecop.return }

  describe '#count_by_year' do

    subject { query.count_by_year }

    context 'with already visited countries' do
      context 'when countries are uniq' do
        let!(:checkin) do
          create(:checkin, user: user, checkin_date: now - 1.year)
        end
        let!(:checkin_b) do
          create(:checkin, user: user, checkin_date: now - 1.year)
        end
        let!(:checkin_c) do
          create(:checkin, user: user, checkin_date: now)
        end

        it { expect(subject).to eq(2016 => 2, 2017 => 1) }
      end

      context 'when countries are not uniq' do
        let(:country) { create(:country) }
        let!(:checkin) do
          create(
            :checkin, user: user, country: country, checkin_date: now - 1.year
          )
        end
        let!(:checkin_b) do
          create(:checkin, user: user, checkin_date: now)
        end
        let!(:checkin_c) do
          create(:checkin, user: user, country: country, checkin_date: now)
        end

        it { expect(subject).to eq(2016 => 1, 2017 => 1) }
      end
    end

    context 'with mixed countries' do
      let!(:checkin) { create(:checkin, user: user, checkin_date: now) }
      let!(:checkin_b) do
        create(:checkin, user: user, checkin_date: now + 1.day)
      end

      it { expect(subject).to eq(2017 => 1) }
    end

    context 'with not visited countries' do
      let!(:checkin) do
        create(:checkin, user: user, checkin_date: now + 1.day)
      end

      it { expect(subject).to be_empty }
    end
  end
end
