describe Currency do
  it { is_expected.to belong_to(:country) }

  it { is_expected.to validate_presence_of(:code) }
end
