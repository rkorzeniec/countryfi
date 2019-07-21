describe Checkins::TimelineItemFacade do
  let(:now) { Time.zone.local(2017, 12, 16) }
  let(:checkin) { double(:checkin) }
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
    let(:date) { Date.new(2018, 1, 11) }
    let(:checkin) { double(:checkin, checkin_date: date) }

    subject { facade.checkin_date }

    it { is_expected.to eq('2018-01-11') }
  end

  describe '#checkin_year' do
    let(:date) { Date.new(2018, 1, 11) }
    let(:checkin) { double(:checkin, checkin_date: date) }

    subject { facade.checkin_year }

    it { is_expected.to eq(2018) }
  end

  describe '#country_cca2' do
    let(:country) { double(:country, cca2: 'CH') }
    let(:checkin) { double(:checkin, country: country) }

    subject { facade.country_cca2 }

    it { is_expected.to eq('CH') }
  end

  describe '#country_common_name' do
    let(:country) { double(:country, name_common: 'Switzerland') }
    let(:checkin) { double(:checkin, country: country) }

    subject { facade.country_common_name }

    it { is_expected.to eq('Switzerland') }
  end

  describe '#flag_image_path' do
    let(:country) { double(:country, flag_image_path: 'images/flags/ch.png') }
    let(:checkin) { double(:checkin, country: country) }

    subject { facade.flag_image_path }

    it { is_expected.to eq('images/flags/ch.png') }
  end
end
