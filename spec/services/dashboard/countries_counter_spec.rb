# frozen_string_literal: true

describe Dashboard::CountriesCounter do
  let(:counter) { described_class.new(user) }
  let(:user) { build_stubbed(:user) }

  shared_context 'with cached method' do
    let(:cache) { instance_double('cache') }
    let(:cache_key) do
      ['dashboard/countries_counter', method_name, user.cache_key].join('/')
    end

    it do
      expect(Rails).to receive(:cache).and_return(cache)
      expect(cache).to receive(:fetch).with(cache_key, expires_in: 1.week)
      subject
    end
  end

  describe '#countries_count' do
    subject { counter.countries_count }

    let(:countries) { [double(:country)] }

    it_behaves_like 'with cached method' do
      let(:method_name) { 'countries_count' }
    end

    context 'with all countries' do
      it do
        expect(Country).to receive(:all).and_return(countries)
        is_expected.to eq(1)
      end
    end

    context 'with independent countries' do
      let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

      it do
        expect(Country).to receive(:independent).and_return(countries)
        is_expected.to eq(1)
      end
    end

    context 'with un countries' do
      let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }
      it do
        expect(Country).to receive(:un_member).and_return(countries)
        is_expected.to eq(1)
      end
    end
  end

  %i[
    european north_american south_american asian african oceanian antarctican
  ].each do |region|
    describe "##{region}_countries_count" do
      subject { counter.send("#{region}_countries_count") }

      let(:countries_relation) { instance_double('relation') }
      let(:countries) { [double(:country)] }

      it_behaves_like 'with cached method' do
        let(:method_name) { "#{region}_countries_count" }
      end

      context 'with all countries' do
        it do
          expect(Country).to receive(:all).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end

      context 'with independent countries' do
        let(:user) { build_stubbed(:user, countries_cluster: 'independent') }

        it do
          expect(Country).to receive(:independent).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end

      context 'with un countries' do
        let(:user) { build_stubbed(:user, countries_cluster: 'un_member') }
        it do
          expect(Country).to receive(:un_member).and_return(countries_relation)
          allow(countries_relation).to receive(region).and_return(countries)
          is_expected.to eq(1)
        end
      end
    end
  end
end
