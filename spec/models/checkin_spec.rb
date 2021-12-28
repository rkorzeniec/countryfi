# frozen_string_literal: true

describe Checkin do
  it { is_expected.to belong_to(:user).touch(true) }
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:checkin_date) }

  describe '.world' do
    let(:european_country) { create(:country) }
    let(:asian_country) { create(:country, :asian) }

    it do
      expect { create(:checkin, country: european_country) }.to change {
        described_class.world.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: asian_country) }.to change {
        described_class.world.count
      }.from(0).to(1)
    end
  end

  describe '.european' do
    let(:european_country) { create(:country) }
    let(:asian_country) { create(:country, :asian) }

    it do
      expect { create(:checkin, country: european_country) }.to change {
        described_class.european.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: asian_country) }.not_to change {
        described_class.european.count
      }
    end
  end

  describe '.asian' do
    let(:european_country) { create(:country) }
    let(:asian_country) { create(:country, :asian) }

    it do
      expect { create(:checkin, country: asian_country) }.to change {
        described_class.asian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.asian.count
      }
    end
  end

  describe '.african' do
    let(:european_country) { create(:country) }
    let(:african_country) { create(:country, :african) }

    it do
      expect { create(:checkin, country: african_country) }.to change {
        described_class.african.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.african.count
      }
    end
  end

  describe '.antarctican' do
    let(:european_country) { create(:country) }
    let(:antarctican_country) { create(:country, :antarctican) }

    it do
      expect { create(:checkin, country: antarctican_country) }.to change {
        described_class.antarctican.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.antarctican.count
      }
    end
  end

  describe '.oceanian' do
    let(:european_country) { create(:country) }
    let(:oceanian_country) { create(:country, :oceanian) }

    it do
      expect { create(:checkin, country: oceanian_country) }.to change {
        described_class.oceanian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.oceanian.count
      }
    end
  end

  describe '.north_american' do
    let(:european_country) { create(:country) }
    let(:north_american_country) { create(:country, :north_american) }

    it do
      expect { create(:checkin, country: north_american_country) }.to change {
        described_class.north_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.north_american.count
      }
    end
  end

  describe '.south_american' do
    let(:european_country) { create(:country) }
    let(:south_american_country) { create(:country, :south_american) }

    it do
      expect { create(:checkin, country: south_american_country) }.to change {
        described_class.south_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        described_class.south_american.count
      }
    end
  end

  describe '.in_past' do
    it do
      expect { create(:checkin, checkin_date: Time.current) }.to change {
        described_class.in_past.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, checkin_date: 1.day.from_now) }.not_to change {
        described_class.in_past.count
      }
    end
  end

  describe '#in_past?' do
    subject { checkin.in_past? }

    let(:now) { Time.current }

    before { Timecop.freeze(now) }

    after { Timecop.return }

    context 'when future' do
      let(:checkin) do
        build_stubbed(:checkin, checkin_date: now + 1.day)
      end

      it { is_expected.to be false }
    end

    context 'when today' do
      let(:checkin) do
        build_stubbed(:checkin, checkin_date: now)
      end

      it { is_expected.to be true }
    end

    context 'when past' do
      let(:checkin) do
        build_stubbed(:checkin, checkin_date: now - 1.day)
      end

      it { is_expected.to be true }
    end
  end
end
