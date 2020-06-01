# frozen_string_literal: true
describe CountryCallingCode do
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:calling_code) }
end
