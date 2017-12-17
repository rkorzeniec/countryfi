describe Country do
  it { is_expected.to have_many(:checkins) }
  it { is_expected.to have_many(:currencies) }
  it { is_expected.to have_many(:top_level_domains) }
  it { is_expected.to have_many(:country_languages) }
  it { is_expected.to have_many(:country_calling_codes) }
  it { is_expected.to have_many(:border_countries) }
  it { is_expected.to have_many(:country_alternative_spellings) }

  describe '.find_by_any' do
    let(:switzerland) { create(:country) }
    let(:united_states) do
      create(
        :country,
        name_common: 'United States', name_official: 'United States of America',
        cca2: 'US', ccn3: '840', cca3: 'USA', cioc: 'USA'
      )
    end

    before do
      united_states
      switzerland
    end

    subject { described_class.find_by_any(name) }

    context 'when name is cca2' do
      let(:name) { 'CH' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is ccn3' do
      let(:name) { 756 }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is cca3' do
      let(:name) { 'CHE' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is cioc' do
      let(:name) { 'SUI' }

      it { expect(subject).to eq(switzerland) }
    end

    context 'when name is neither' do
      let(:name) { nil }

      it { expect(subject).to eq(Country.first) }
    end
  end

  describe '#european' do
    it do
      expect { create(:country) }.to change {
        Country.european.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country, :asian) }.not_to change {
        Country.european.count
      }
    end
  end

  describe '#asian' do
    it do
      expect { create(:country, :asian) }.to change {
        Country.asian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.asian.count
      }
    end
  end

  describe '#african' do
    it do
      expect { create(:country, :african) }.to change {
        Country.african.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.african.count
      }
    end
  end

  describe '#antarctican' do
    it do
      expect { create(:country, :antarctican) }.to change {
        Country.antarctican.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.antarctican.count
      }
    end
  end

  describe '#oceanian' do
    it do
      expect { create(:country, :oceanian) }.to change {
        Country.oceanian.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.oceanian.count
      }
    end
  end

  describe '#north_american' do
    it do
      expect { create(:country, :north_american) }.to change {
        Country.north_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.north_american.count
      }
    end
  end

  describe '#south_american' do
    it do
      expect { create(:country, :south_american) }.to change {
        Country.south_american.count
      }.from(0).to(1)
    end

    it do
      expect { create(:country) }.not_to change {
        Country.south_american.count
      }
    end
  end

  describe '#flag_image_path' do
    subject { country.flag_image_path }

    context 'when flag exist' do
      let(:country) { build_stubbed(:country, cca2: 'mambo') }

      it do
        is_expected.to eq(
          ActionController::Base.helpers.asset_path('flags/unknown.png')
        )
      end
    end

    context 'when flag does not exist' do
      let(:country) { build_stubbed(:country, cca2: 'ch') }

      it { is_expected.to eq('/images/flags/ch.png') }
    end
  end
end

# describe '#image_path' do

#     subject { vehicle.image_path('120') }

#     context 'when vehicle has photos and not in development env' do
#       let(:photo) { build_stubbed(:photo, vehicle: vehicle) }
#       let(:photo_b) { build_stubbed(:photo, vehicle: vehicle) }

#       before do
#         allow(Rails).to receive(:env).and_return(
#           double(:env, development?: false, to_s: 'ENV')
#         )

#         allow(vehicle).to receive(:photos).and_return([photo, photo_b])
#       end

#       it { is_expected.to eq(photo.image_path('120')) }
#     end

#     context 'when photos are empty' do
#       it do
#         is_expected.to eq(
#           ActionController::Base.helpers.asset_path(
#             'placeholders/car_image_placeholder_120.png'
#           )
#         )
#       end
#     end

#     context 'when in development env' do
#       let!(:photo) { build_stubbed(:photo, vehicle: vehicle) }

#       before do
#         allow(Rails).to receive(:env).and_return(
#           double(:env, development?: true, to_s: 'ENV')
#         )

#         allow(vehicle).to receive(:photos).and_return([photo])
#       end

#       it do
#         is_expected.to eq(
#           ActionController::Base.helpers.asset_path(
#             'placeholders/car_image_placeholder_120.png'
#           )
#         )
#       end
#     end
#   end
