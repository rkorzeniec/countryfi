# frozen_string_literal: true

describe TimelineCheckinsQuery do
  let(:user) { create(:user) }
  let(:options) { {} }
  # let(:now) { Time.zone.local(2017, 10, 9) }
  let(:query) { described_class.new(user, options: options) }

  # before { Timecop.freeze(now) }

  # after { Timecop.return }

  it do
    expect(described_class::ALLOWED_SCOPES).to eq(
      %w[african antarctican asian european north_american oceanian south_american]
    )
  end

  describe '#query' do
    subject { query.query }

    let(:country) { create(:country, :african) }
    let(:country_b) { create(:country) }
    let!(:checkin) do
      create(:checkin, user: user, country: country, checkin_date: '2017-02-01')
    end
    let!(:checkin_b) do
      create(:checkin, user: user, country: country, checkin_date: '2017-01-01')
    end
    let!(:checkin_c) { create(:checkin, user: user, country: country_b) }

    it { is_expected.to eq([checkin_c, checkin, checkin_b]) }

    context 'with allowed scope' do
      let(:options) { { scope: 'african' } }

      it { is_expected.to eq([checkin, checkin_b]) }
    end

    context 'with disallowed scope' do
      let(:options) { { scope: 'jambo' } }

      it { is_expected.to eq([checkin_c, checkin, checkin_b]) }
    end

    context 'with page' do
      let(:options) { { page: 1 } }

      it { is_expected.to eq([checkin_c, checkin, checkin_b]) }

      context 'when distant page' do
        let(:options) { { page: 2 } }

        it { is_expected.to eq([]) }
      end
    end
  end
end
