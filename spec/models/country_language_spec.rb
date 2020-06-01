# frozen_string_literal: true

describe CountryLanguage do
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:name) }

  describe 'name_and_code' do
    subject { language.name_and_code }

    let(:language) { build_stubbed(:country_language) }

    it { is_expected.to eq('English (eng)') }
  end
end
