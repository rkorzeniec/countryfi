# frozen_string_literal: true

describe Profile::YearlyCountriesChartDecorator do
  let(:decorator) { described_class.new(user) }
  let(:user) { build_stubbed(:user) }

  let(:unique_query) do
    instance_double(
      UniqVisitedCountriesQuery,
      count_by_year: { 1992 => 1, 2001 => 2, 2005 => 1, 2020 => 5 }
    )
  end
  let(:all_query) do
    instance_double(
      VisitedCountriesQuery,
      count_by_year: { 1992 => 2, 2000 => 4, 2019 => 2, 2020 => 10 }
    )
  end

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) do
      [
        'profile/yearly_countries_chart_decorator',
        method_name,
        user.cache_key
      ].join('/')
    end

    it do
      expect(Rails).to receive(:cache).and_return(cache)
      expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
      subject
    end
  end

  describe '#call' do
    subject { decorator.call }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'call' }
    end

    it do
      expect(VisitedCountriesQuery).to receive(:new)
        .with(user).and_return(all_query)
      expect(UniqVisitedCountriesQuery).to receive(:new)
        .with(user).and_return(unique_query)

      is_expected.to eq(
        [
          { name: 'all', data: { 1992 => 2, 2000 => 4, 2019 => 2, 2020 => 10 } },
          { name: 'unique', data: { 1992 => 1, 2001 => 2, 2005 => 1, 2020 => 5} }
        ]
      )
    end
  end
end
