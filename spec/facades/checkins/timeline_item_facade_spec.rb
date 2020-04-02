describe Checkins::TimelineItemFacade do
  let(:now) { Time.zone.local(2017, 12, 16) }
  let(:checkin) { instance_double('checkin') }
  let(:facade) { described_class.new(checkin) }

  before { Timecop.freeze(now) }

  after { Timecop.return }

  describe 'delegations' do
    it { expect(facade).to delegate_method(:country).to(:checkin) }
    it { expect(facade).to delegate_method(:flag_image_path).to(:country) }

    it do
      expect(facade).to delegate_method(:cca2).to(:country).with_prefix(true)
    end
  end

  describe '#checkin_date' do
    subject { facade.checkin_date }

    let(:date) { Date.new(2018, 1, 11) }
    let(:checkin) { instance_double('checkin', checkin_date: date) }

    it { is_expected.to eq('2018-01-11') }
  end

  describe '#checkin_year' do
    subject { facade.checkin_year }

    let(:date) { Date.new(2018, 1, 11) }
    let(:checkin) { instance_double('checkin', checkin_date: date) }

    it { is_expected.to eq(2018) }
  end

  describe '#country_cca2' do
    subject { facade.country_cca2 }

    let(:country) { instance_double('country', cca2: 'CH') }
    let(:checkin) { instance_double('checkin', country: country) }

    it { is_expected.to eq('CH') }
  end

  describe '#country_common_name' do
    subject { facade.country_common_name }

    let(:country) { instance_double('country', name_common: 'Switzerland') }
    let(:checkin) { instance_double('checkin', country: country) }

    it { is_expected.to eq('Switzerland') }
  end

  describe '#flag_image_path' do
    subject { facade.flag_image_path }

    let(:country) do
      instance_double('country', flag_image_path: 'images/flags/ch.png')
    end

    let(:checkin) { instance_double('checkin', country: country) }

    it { is_expected.to eq('images/flags/ch.png') }
  end
end
