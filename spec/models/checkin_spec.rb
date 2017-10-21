describe Checkin do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:checkin_date) }

  describe '#european' do
    let(:european_country) { create(:country) }
    let(:asian_country) { create(:country, :asian) }

    it do
      expect { create(:checkin, country: european_country) }.to change {
        Checkin.european.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: asian_country) }.not_to change {
        Checkin.european.count
      }
    end
  end

  describe '#asian' do
    let(:european_country) { create(:country) }
    let(:asian_country) { create(:country, :asian) }

    it do
      expect { create(:checkin, country: asian_country) }.to change {
        Checkin.asian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.asian.count
      }
    end
  end

  describe '#african' do
    let(:european_country) { create(:country) }
    let(:african_country) { create(:country, :african) }

    it do
      expect { create(:checkin, country: african_country) }.to change {
        Checkin.african.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.african.count
      }
    end
  end

  describe '#antarctican' do
    let(:european_country) { create(:country) }
    let(:antarctican_country) { create(:country, :antarctican) }

    it do
      expect { create(:checkin, country: antarctican_country) }.to change {
        Checkin.antarctican.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.antarctican.count
      }
    end
  end

  describe '#oceanian' do
    let(:european_country) { create(:country) }
    let(:oceanian_country) { create(:country, :oceanian) }

    it do
      expect { create(:checkin, country: oceanian_country) }.to change {
        Checkin.oceanian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.oceanian.count
      }
    end
  end

  describe '#north_american' do
    let(:european_country) { create(:country) }
    let(:north_american_country) { create(:country, :north_american) }

    it do
      expect { create(:checkin, country: north_american_country) }.to change {
        Checkin.north_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.north_american.count
      }
    end
  end

  describe '#south_american' do
    let(:european_country) { create(:country) }
    let(:south_american_country) { create(:country, :south_american) }

    it do
      expect { create(:checkin, country: south_american_country) }.to change {
        Checkin.south_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, country: european_country) }.not_to change {
        Checkin.south_american.count
      }
    end
  end

  describe '#visited' do
    it do
      expect { create(:checkin, checkin_date: Time.current) }.to change {
        Checkin.visited.count
      }.from(0).to(1)
    end

    it do
      expect { create(:checkin, checkin_date: Time.current + 1.day) }.not_to change {
        Checkin.visited.count
      }
    end
  end
end
