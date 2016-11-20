describe Checkin do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:country) }
end
