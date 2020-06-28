# frozen_string_literal: true

describe Demonym do
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_presence_of(:gender) }
  it { is_expected.to validate_presence_of(:name) }
end
