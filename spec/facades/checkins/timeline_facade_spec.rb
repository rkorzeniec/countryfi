describe Checkins::TimelineFacade do
  let(:now) { Time.zone.local(2017, 12, 16) }
  let(:facade) { described_class.new(checkins) }

  before { Timecop.freeze(now) }

  after { Timecop.return }

  describe 'delegations' do
    subject { facade }

    let(:checkins) { [checkin] }
    let(:checkin) { instance_double(Checkin) }

    it { is_expected.to delegate_method(:total_pages).to(:checkins) }
    it { is_expected.to delegate_method(:current_page).to(:checkins) }
    it { is_expected.to delegate_method(:next_page).to(:checkins) }
    it { is_expected.to delegate_method(:limit_value).to(:checkins) }
  end

  describe '#items' do
    subject { facade.items }

    let(:checkins) { [checkin, checkin_b] }
    let(:checkin) { instance_double(Checkin) }
    let(:checkin_b) { instance_double(Checkin) }

    it do
      expect(Checkins::TimelineItemFacade).to receive(:new).with(checkin)
      expect(Checkins::TimelineItemFacade).to receive(:new).with(checkin_b)

      expect(subject.size).to eq(2)
    end
  end

  describe '#today_marker?' do
    subject { facade.today_marker?(0) }

    context 'when single checkin' do
      let(:date) { Date.new(2018, 1, 11) }
      let(:checkins) { [checkin] }
      let(:checkin) { instance_double('checkin', checkin_date: date) }

      it { is_expected.to be_falsey }
    end

    context 'when multiple checkins' do
      let(:checkins) { [checkin, checkin_b] }
      let(:checkin) { instance_double('checkin', checkin_date: date) }

      context 'when checkin in future' do
        let(:date) { Date.new(2018, 2, 11) }
        let(:checkin_b) { instance_double('checkin', checkin_date: date_b) }

        context 'when next checkin in furute' do
          let(:date_b) { Date.new(2018, 1, 1) }

          it { is_expected.to be_falsey }
        end

        context 'when next checkin in present' do
          let(:date_b) { Date.new(2017, 12, 16) }

          it { is_expected.to be_falsey }
        end

        context 'when next checkin in past' do
          let(:date_b) { Date.new(2017, 1, 1) }

          it { is_expected.to be_truthy }
        end
      end

      context 'when checkin in past' do
        let(:date) { Date.new(2017, 10, 11) }
        let(:checkin_b) { instance_double('checkin', checkin_date: date_b) }

        context 'when next checkin in furute' do
          let(:date_b) { Date.new(2018, 1, 1) }

          it { is_expected.to be_falsey }
        end

        context 'when next checkin in present' do
          let(:date_b) { Date.new(2017, 12, 16) }

          it { is_expected.to be_falsey }
        end

        context 'when next checkin in past' do
          let(:date_b) { Date.new(2017, 1, 1) }

          it { is_expected.to be_falsey }
        end
      end
    end
  end

  describe '#year_marker?' do
    subject { facade.year_marker?(0) }

    context 'when single checkin' do
      let(:checkins) { [checkin] }
      let(:checkin) { instance_double(Checkin) }

      it { is_expected.to be_falsey }
    end

    context 'when multiple checkins' do
      let(:date) { Date.new(2018, 11, 11) }
      let(:checkins) { [checkin, checkin_b] }
      let(:checkin) { instance_double('checkin', checkin_date: date) }

      context 'when different year' do
        let(:date_b) { Date.new(2017, 11, 11) }
        let(:checkin_b) { instance_double('checkin', checkin_date: date_b) }

        it { is_expected.to be_truthy }
      end

      context 'when same year' do
        let(:checkin_b) { instance_double('checkin', checkin_date: date) }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#future_checkin?' do
    subject { facade.future_checkin?(0) }

    let(:checkins) { [checkin] }
    let(:checkin) { instance_double('checkin', checkin_date: date) }

    context 'when in past' do
      let(:date) { Date.new(2017, 11, 11) }

      it { is_expected.to be_falsey }
    end

    context 'when in present' do
      let(:date) { Date.new(2017, 12, 16) }

      it { is_expected.to be_truthy }
    end

    context 'when in future' do
      let(:date) { Date.new(2018, 1, 1) }

      it { is_expected.to be_truthy }
    end
  end
end
